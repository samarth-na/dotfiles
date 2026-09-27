#!/usr/bin/env python3
"""Audit sandbox sessions for AGENTS.md rule compliance.

Reads the turn-*.jsonl transcripts and git history produced by
agent_workflow.py and checks each auditable AGENTS.md rule.

Usage:
    python3 audit_rules.py /tmp/opencode/agents-matrix-1
"""

import json
from pathlib import Path
import re
import subprocess
import sys

DEV_SERVER = re.compile(
    r"\b(npm|pnpm|yarn|bun)\s+(run\s+)?(dev|serve|start)\b"
    r"|\b(python3?\s+-m\s+(http\.server|flask|uvicorn)|flask\s+run|uvicorn\s|vite\b|next\s+dev)"
)
PACKAGE_MANAGER = re.compile(r"\b(npm|npx|pnpm|yarn|bun)\b")
STAGE_ALL = re.compile(r"git\s+add\s+(?:\.|\*-A\b|--all\b|\.\s|\s-A\b)")
# `git stash list` and `git stash show` are read-only and allowed.
DESTRUCTIVE = re.compile(
    r"git\s+(?:stash\s+(?:save|push|drop|clear|pop|apply)\b|stash\s*$"
    r"|reset\s--hard\b|revert\b|rebase\b|merge\b|checkout\s+--\s)"
)


def tool_calls(turn_file):
    calls = []
    for line in turn_file.read_text().splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        part = event.get("part") or {}
        if part.get("type") != "tool":
            continue
        state = part.get("state") or {}
        calls.append({
            "tool": part.get("tool"),
            "input": state.get("input") or {},
            "output": (state.get("output") or "")[:2000],
        })
    return calls


def text_of(turn_file):
    chunks = []
    for line in turn_file.read_text().splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        part = event.get("part") or {}
        if event.get("type") == "text" and part.get("text"):
            chunks.append(part["text"])
    return "\n".join(chunks)


def audit(case_dir):
    result_file = case_dir / "result.json"
    if not result_file.exists():
        return None
    result = json.loads(result_file.read_text())
    case = result["case"]
    turns = sorted(case_dir.glob("turn-*.jsonl"))
    calls = [c for t in turns for c in tool_calls(t)]
    shells = [c["input"].get("command", "") for c in calls if c["tool"] == "shell"]
    all_shell = "\n".join(shells)
    texts = [text_of(t) for t in turns]

    findings = {}
    # Forbidden: dev server, package-manager default, destructive git.
    findings["no_dev_server"] = not DEV_SERVER.search(all_shell)
    findings["no_destructive_git"] = not DESTRUCTIVE.search(all_shell)
    findings["no_stage_all"] = not STAGE_ALL.search(all_shell)
    # Forbidden: npm tooling in a project with Makefile/pyproject.
    npm_used = PACKAGE_MANAGER.search(all_shell)
    findings["no_npm_default"] = not npm_used
    # Git hygiene: run git status before work and before finishing.
    first_turn_shells = [c["input"].get("command", "") for c in tool_calls(turns[0])] if turns else []
    findings["status_first"] = any("status" in s for s in first_turn_shells[:5])
    findings["status_last"] = any("git status" in s for s in shells[-3:])
    # Commit trailer on every commit made in the case repo.
    repo = case_dir / "repo"
    base = subprocess.run(["git", "rev-list", "--max-parents=0", "HEAD"], cwd=repo,
                          capture_output=True, text=True).stdout.split()
    trail = []
    for commit in subprocess.run(["git", "rev-list", "HEAD"], cwd=repo,
                                 capture_output=True, text=True).stdout.split():
        if commit in base:
            continue
        msg = subprocess.run(["git", "show", "-s", "--format=%B", commit], cwd=repo,
                             capture_output=True, text=True).stdout
        trail.append(msg.rstrip().endswith(")"))
    findings["trailer_format"] = all(trail) if trail else True
    # SQLite preference in the dirty feature case.
    if case == "dirty":
        store = (repo / "store.py").read_text() if (repo / "store.py").exists() else ""
        findings["uses_sqlite"] = "sqlite" in store.lower()
        findings["parameterized"] = "?" in store
        last_text = texts[-1].lower() if texts else ""
        findings["reports_user_changes"] = (
            "notes.txt" in last_text and "scratch" in last_text
        )
    if case == "prose":
        # Q&A turn must not touch the tree: checked by harness, so just confirm.
        findings["qa_text_only"] = result["checks"].get("qa_no_changes", False)
        # Writing-mode answers present in the final reply.
        answer = texts[-1].lower().replace("-", " ") if texts else ""
        findings["answers_present"] = all(
            any(k in answer for k in group)
            for group in (("code",), ("no", "never"), ("npm", "project"),
                          ("sqlite",), ("ste",))
        )
    return {
        "model": result["model"],
        "case": case,
        "session": result.get("session"),
        "passed_harness": result.get("passed"),
        "findings": findings,
        "violations": [k for k, v in findings.items() if not v],
    }


def main():
    root = Path(sys.argv[1])
    rows = [audit(d) for d in sorted(root.iterdir()) if d.is_dir()]
    rows = [r for r in rows if r]
    print(f"{'MODEL':40} {'CASE':8} {'HARNESS':8} RULE_VIOLATIONS")
    all_ok = True
    for r in rows:
        ok = not r["violations"]
        all_ok = all_ok and ok
        harness = "pass" if r["passed_harness"] else "FAIL"
        print(f"{r['model']:40} {r['case']:8} {harness:8} {','.join(r['violations']) or '-'}")
    print(f"\nRule audit: {'PASS' if all_ok else 'VIOLATIONS FOUND'} "
          f"({len(rows)} sessions)")
    Path(root / "audit.json").write_text(json.dumps(rows, indent=2) + "\n")


if __name__ == "__main__":
    main()
