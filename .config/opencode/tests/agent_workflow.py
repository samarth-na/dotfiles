#!/usr/bin/env python3
"""Compare general-agent behavior across free models in isolated sandboxes.

Each case gets a private git repository plus private OpenCode state (HOME and
XDG directories) inside a Bubblewrap sandbox. The sandbox mounts the host
filesystem read-only, so an agent can write only inside its own case directory.

Usage:
    python3 agent_workflow.py --probe
    python3 agent_workflow.py --root /tmp/opencode/run-1 --workers 4
"""

from __future__ import annotations

import argparse
import concurrent.futures
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

AGENTS = Path(__file__).resolve().parents[1] / "AGENTS.md"

MODELS = [
    "opencode/longcat-2.5-preview-free",
    "opencode/muse-spark-1.3-contributor-free",
    "opencode/mimo-v2.6-flash-free",
    "opencode/space-bunny-free",
]
SCENARIOS = ["batch", "lines", "files", "dirty", "prose"]

# Cumulative commit counts expected after each turn.
TURN_TIMEOUT = 480
EXPECTED = {
    "batch": [0, 0, 1],
    "lines": [1],
    "files": [1],
    "dirty": [1],
    "prose": [0, 0],
}


def git(repo, *args):
    # rstrip only the newline: porcelain status keeps leading spaces that
    # carry meaning (index vs worktree state).
    return subprocess.check_output(["git", *args], cwd=repo, text=True).rstrip("\n")


def put(root, path, text):
    target = root / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(text)


def setup(root, case):
    for name in ("repo", "home", "config/opencode", "data", "cache", "state"):
        (root / name).mkdir(parents=True, exist_ok=True)
    (root / "opencode").touch()
    repo = root / "repo"
    shutil.copyfile(AGENTS, repo / "AGENTS.md")
    put(repo, "README.md", "# Task traker\n\nA local task utilty.\n")
    put(repo, "app.py", 'LABEL = "Task tracker"\nMAX_TITLE = 80\n\n\ndef title(text):\n    return text.strip()[:MAX_TITLE]\n')
    put(repo, "tests/test_app.py", 'import unittest\n\nfrom app import title\n\n\nclass TitleTest(unittest.TestCase):\n    def test_strip(self):\n        self.assertEqual(title(" task "), "task")\n')
    put(repo, "Makefile", "test:\n\tpython3 -m unittest discover -s tests -t .\n")
    put(repo, "pyproject.toml", '[project]\nname = "task-tracker"\nversion = "0.1.0"\nrequires-python = ">=3.10"\ndependencies = []\n')
    put(repo, ".gitignore", "__pycache__/\n*.db\n")
    put(repo, "notes.txt", "Original personal notes.\n")
    put(repo, "RUNBOOK.md", "# Recovery\n\nIf the database is locked, don't delete it; commence recovery with `tracker recover --wait 30`. Back up `tasks.db` first. Recovery can take up to 30 seconds. Never run two recovery commands together. See [recovery](https://example.com/recovery).\n")
    git(repo, "init", "-q")
    git(repo, "config", "user.name", "Agent Workflow Test")
    git(repo, "config", "user.email", "agent-test@example.invalid")
    git(repo, "config", "commit.gpgsign", "false")
    git(repo, "add", "AGENTS.md", "README.md", "app.py", "tests/test_app.py", "Makefile", "pyproject.toml", ".gitignore", "notes.txt", "RUNBOOK.md")
    git(repo, "commit", "-qm", "Initialize test fixture")
    base = git(repo, "rev-parse", "HEAD")
    if case == "dirty":
        app = (repo / "app.py").read_text()
        put(repo, "app.py", app.replace('"Task tracker"', '"Personal label"').replace("MAX_TITLE = 80", "MAX_TITLE = 120"))
        put(repo, "notes.txt", "User's pre-staged personal notes.\n")
        git(repo, "add", "notes.txt")
        put(repo, "scratch.txt", "User's untracked draft.\n")
    return repo, base


def prompts(case):
    if case == "batch":
        return [
            "fix the typo in the readme heading, just that line",
            "ok also fix 'utilty' in the line under it",
            "now add release docs: make docs/release-01.md to docs/release-10.md, each with a numbered heading and a short description of one distinct step for releasing this python utility. this wraps up the release docs",
        ]
    if case == "lines":
        return [
            "make data/codes.json, pretty-printed json array of exactly 105 objects, each object with code 1..105 and label 'Task N' matching the code. that's the full import fixture",
        ]
    if case == "files":
        return [
            "add docs/command-01.md through docs/command-10.md, one short distinct task-tracker command example in each. that finishes the command examples",
        ]
    if case == "dirty":
        return [
            "implement a complete local task store in store.py: add, get, list, complete, delete, persists across connections, parameterized queries. use sqlite for this quick db. in app.py make title() raise ValueError on empty input or over MAX_TITLE instead of truncating. a colleague already bumped MAX_TITLE to 120 for this feature. the LABEL change in app.py, notes.txt and scratch.txt are my own unrelated stuff, leave them alone. add useful tests for persistence, invalid titles and the task lifecycle, update README with usage. finish the feature and run the project checks",
        ]
    return [
        "rewrite RUNBOOK.md for clarity using my writing rules. keep every command, link, requirement, warning and time limit",
        "don't change files or run commands, just answer in numbered order: 1. what do you inspect before a browser or web MCP tool? 2. do you start a dev server to preview this project? 3. how do you pick the package manager? 4. which db for a quick prototype? 5. which writing mode applies to API docs? 6. do the writing rules cover code identifiers and nontechnical poetry? 7. what makes a commit due? 8. whose edits can go into that commit?",
    ]


def command(root, model, title, prompt, session=None):
    # The host filesystem is read-only. /home and /tmp are hidden, so the only
    # writable surface is the case directory plus ephemeral mounts.
    binary = shutil.which("opencode")
    # /run stays visible because /etc/resolv.conf points into
    # /run/systemd/resolve. Hiding /run breaks DNS inside the sandbox.
    cmd = [
        "bwrap", "--ro-bind", "/", "/", "--tmpfs", "/home", "--tmpfs", "/tmp",
        "--bind", str(root), str(root),
        "--ro-bind", binary, str(root / "opencode"),
        "--dev", "/dev", "--proc", "/proc", "--unshare-pid", "--die-with-parent",
        "--clearenv",
    ]
    for key, value in (("HOME", "home"), ("XDG_CONFIG_HOME", "config"),
                       ("XDG_DATA_HOME", "data"), ("XDG_CACHE_HOME", "cache"),
                       ("XDG_STATE_HOME", "state")):
        cmd += ["--setenv", key, str(root / value)]
    cmd += ["--setenv", "PATH", "/usr/local/bin:/usr/bin:/bin",
            "--chdir", str(root / "repo")]
    cmd += [str(root / "opencode"), "run", "--standalone", "--auto",
            "--agent", "general", "--model", model, "--format", "json"]
    cmd += ["--session", session] if session else ["--title", title]
    return cmd + [prompt]


def parse_events(text):
    out = []
    for line in text.splitlines():
        try:
            out.append(json.loads(line))
        except json.JSONDecodeError:
            pass
    return out


def final_text(events):
    chunks = []
    for e in events:
        part = e.get("part")
        if e.get("type") == "text" and isinstance(part, dict) and part.get("text"):
            chunks.append(part["text"])
    return "\n".join(chunks)


def commit_list(repo, base):
    return [line for line in git(repo, "rev-list", "--reverse", f"{base}..HEAD").splitlines() if line]


def check(repo, base, case, counts, statuses, session, title, texts):
    checks = {}
    commits = commit_list(repo, base)
    status = statuses[-1] if statuses else git(repo, "status", "--porcelain")
    checks["commit_cadence"] = counts == EXPECTED[case]

    if case in ("batch", "lines", "files"):
        checks["own_work_committed"] = status == ""
    if case == "batch":
        readme = git(repo, "show", "HEAD:README.md")
        checks["earlier_edits_included"] = "traker" not in readme and "utilty" not in readme
        checks["release_docs"] = len(list((repo / "docs").glob("release-*.md"))) == 10
    if case == "files":
        checks["command_docs"] = len(list((repo / "docs").glob("command-*.md"))) == 10
    if case == "lines":
        try:
            data = json.loads((repo / "data/codes.json").read_text())
        except (OSError, ValueError):
            data = None
        checks["fixture_complete"] = data == [{"code": n, "label": f"Task {n}"} for n in range(1, 106)]
    if case == "dirty":
        patch = git(repo, "log", "-p", "--", "app.py", "notes.txt")
        head_app = git(repo, "show", "HEAD:app.py")
        checks["unrelated_not_committed"] = 'LABEL = "Personal label"' not in patch and "User's pre-staged" not in patch
        checks["related_exception"] = "MAX_TITLE = 120" in head_app and 'LABEL = "Task tracker"' in head_app
        checks["head_notes_untouched"] = git(repo, "show", "HEAD:notes.txt") == "Original personal notes."
        checks["user_work_preserved"] = (
            "User's pre-staged personal notes." in (repo / "notes.txt").read_text()
            and 'LABEL = "Personal label"' in (repo / "app.py").read_text()
            and (repo / "scratch.txt").read_text() == "User's untracked draft.\n"
        )
        checks["staged_user_work_preserved"] = git(repo, "diff", "--cached", "--name-only") == "notes.txt"
        checks["leftovers_only_user"] = sorted(status.splitlines()) == sorted(["M  notes.txt", " M app.py", "?? scratch.txt"])
        tests = subprocess.run([sys.executable, "-m", "unittest", "discover", "-s", "tests", "-t", "."], cwd=repo, capture_output=True, text=True, timeout=120)
        checks["tests_pass"] = tests.returncode == 0
    if case == "prose":
        runbook = (repo / "RUNBOOK.md").read_text()
        checks["runbook_rules"] = (
            "commence" not in runbook
            and "don't" not in runbook
            and "tracker recover --wait 30" in runbook
            and "https://example.com/recovery" in runbook
            and "30 seconds" in runbook
            and "back up" in runbook.lower()
        )
        checks["qa_no_changes"] = (
            len(statuses) >= 2
            and {line.strip() for line in statuses[0].splitlines()}
            == {line.strip() for line in statuses[1].splitlines()}
        )
        checks["deferred_small_edit"] = "RUNBOOK.md" in status and len(commits) == 0
        # Soft keyword check per question. Any listed keyword satisfies a
        # question, so terse but correct answers are not penalized.
        text = texts.get(2, "").lower().replace("-", " ")
        answer_groups = [
            ("code",),                                # 1 read code first
            ("no", "never"),                          # 2 no dev server
            ("package manager", "npm", "project"),    # 3 project tooling
            ("sqlite",),                              # 4 quick db
            ("ste",),                                 # 5 API docs mode
            ("not", "no", "ignore", "exempt"),        # 6 rules scope
            ("substantial", "milestone", "100"),      # 7 commit trigger
            ("same purpose", "same code", "your own"),  # 8 staging scope
        ]
        checks["answers"] = all(any(k in text for k in g) for g in answer_groups)

    info = {"commit_count": len(commits), "trailer_ok": [], "body_ok": [], "final_text": texts.get(max(texts), "") if texts else ""}
    for c in commits:
        msg = git(repo, "show", "-s", "--format=%B", c)
        info["trailer_ok"].append(msg.rstrip().endswith(f"OpenCode: {title} ({session})"))
        info["body_ok"].append(len([p for p in msg.split("\n\n") if p.strip()]) >= 3)
    return checks, info


def run(root, index, model, case):
    case_root = root / f"{index:02d}-{model.split('/')[-1]}-{case}"
    repo, base = setup(case_root, case)
    title = f"AGENTS workflow {index:02d} {case}"
    session, counts, statuses, texts = None, [], [], {}
    result = {"model": model, "case": case, "title": title, "path": str(case_root)}
    try:
        for turn, prompt in enumerate(prompts(case), 1):
            proc = subprocess.run(command(case_root, model, title, prompt, session), capture_output=True, text=True, timeout=TURN_TIMEOUT)
            put(case_root, f"turn-{turn}.jsonl", proc.stdout)
            put(case_root, f"turn-{turn}.stderr", proc.stderr)
            events = parse_events(proc.stdout)
            session = next((e["sessionID"] for e in events if e.get("sessionID")), session)
            texts[turn] = final_text(events)[:4000]
            if proc.returncode != 0 or not session:
                raise RuntimeError(f"turn {turn} exit={proc.returncode} stderr={proc.stderr[-800:]} stdout={proc.stdout[-800:]}")
            counts.append(len(commit_list(repo, base)))
            statuses.append(git(repo, "status", "--porcelain"))
            put(case_root, f"turn-{turn}.status", statuses[-1])
        checks, info = check(repo, base, case, counts, statuses, session, title, texts)
        result.update(session=session, commits=counts, checks=checks, info=info, passed=all(checks.values()))
    except Exception as error:
        result.update(session=session, commits=counts, passed=False, error=str(error))
    put(case_root, "result.json", json.dumps(result, indent=2) + "\n")
    print(json.dumps(result), flush=True)
    return result


def probe_one(root, i, model):
    case_root = root / f"probe-{i}"
    setup(case_root, "prose")
    proc = subprocess.run(command(case_root, model, "probe", "Reply only READY. Do not use tools."), capture_output=True, text=True, timeout=240)
    text = final_text(parse_events(proc.stdout))
    good = proc.returncode == 0 and "READY" in text
    line = f"{'OK ' if good else 'BAD'} {model:45} exit={proc.returncode} text={text[:40]!r}"
    if not good:
        line += f"\n  stderr={proc.stderr[-300:]}"
        line += f"\n  stdout_tail={proc.stdout[-300:]}"
    return good, line


def probe():
    root = Path(tempfile.mkdtemp(prefix="agents-probe-", dir="/tmp/opencode"))
    with concurrent.futures.ThreadPoolExecutor(max_workers=len(MODELS)) as pool:
        results = list(pool.map(lambda pair: probe_one(root, *pair), enumerate(MODELS)))
    for _, line in results:
        print(line)
    return 0 if all(good for good, _ in results) else 1


def regrade(root):
    """Re-run checks against saved repos and transcripts. No model calls."""
    results = []
    for case_dir in sorted(root.iterdir()):
        if not case_dir.is_dir() or not (case_dir / "result.json").exists():
            continue
        result = json.loads((case_dir / "result.json").read_text())
        if "error" in result:
            results.append(result)
            continue
        repo = Path(result["path"]) / "repo"
        base = git(repo, "rev-list", "--max-parents=0", "HEAD")
        case, model, title, session = result["case"], result["model"], result["title"], result["session"]
        statuses, texts = [], {}
        turns = len(prompts(case))
        last_status_turn = 0
        for turn in range(1, turns + 1):
            if not (case_dir / f"turn-{turn}.status").exists():
                break
            last_status_turn = turn
        for turn in range(1, last_status_turn + 1):
            if turn == last_status_turn:
                # The repo is still in its final state, so the last status is
                # recomputed. Older status files lost leading spaces to a bug.
                statuses.append(git(repo, "status", "--porcelain"))
            else:
                statuses.append((case_dir / f"turn-{turn}.status").read_text().rstrip("\n"))
            turn_file = case_dir / f"turn-{turn}.jsonl"
            if turn_file.exists():
                texts[turn] = final_text(parse_events(turn_file.read_text()))[:4000]
        checks, info = check(repo, base, case, result["commits"], statuses, session, title, texts)
        result.update(checks=checks, info=info, passed=all(checks.values()))
        results.append(result)
        (case_dir / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    put(root, "results.json", json.dumps(results, indent=2) + "\n")
    print("\nMODEL                                      CASE   COMMITS   PASS")
    for r in sorted(results, key=lambda x: (x["model"], x["case"])):
        mark = "PASS" if r.get("passed") else "FAIL"
        fails = ",".join(k for k, v in r.get("checks", {}).items() if not v)
        print(f"{mark}  {r['model']:42} {r['case']:7} {str(r.get('commits')):10} {fails or mark}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--models", help="comma-separated model IDs to test")
    parser.add_argument("--cases", help="comma-separated scenario names to test")
    parser.add_argument("--turn-timeout", type=int, default=480)
    parser.add_argument("--regrade", action="store_true",
                        help="re-check saved sessions without calling models")
    parser.add_argument("--probe", action="store_true")
    args = parser.parse_args()
    global MODELS, SCENARIOS, TURN_TIMEOUT
    if args.models:
        MODELS = [m.strip() for m in args.models.split(",") if m.strip()]
    if args.cases:
        SCENARIOS = [c.strip() for c in args.cases.split(",") if c.strip()]
    TURN_TIMEOUT = args.turn_timeout
    if args.probe:
        raise SystemExit(probe())
    root = args.root or Path(tempfile.mkdtemp(prefix="agents-workflow-", dir="/tmp/opencode"))
    root.mkdir(parents=True, exist_ok=True)
    if args.regrade:
        return regrade(root)
    matrix = [(model, case) for model in MODELS for case in SCENARIOS]
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures = [pool.submit(run, root, i, model, case) for i, (model, case) in enumerate(matrix, 1)]
        results = [f.result() for f in futures]
    put(root, "results.json", json.dumps(results, indent=2) + "\n")
    print("\nMODEL                                      CASE   COMMITS   PASS")
    for r in sorted(results, key=lambda x: (x["model"], x["case"])):
        mark = "PASS" if r.get("passed") else "FAIL"
        print(f"{mark}  {r['model']:42} {r['case']:7} {str(r.get('commits')):10} {mark}")
    print(f"\nResults: {root / 'results.json'}")


if __name__ == "__main__":
    main()
