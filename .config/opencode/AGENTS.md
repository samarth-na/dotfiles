I am Samarth, a software engineer in my final year of college, trying to enter the software industry.
I work with technical content often. Follow these preferences when you help me.

# Preferences

- Read the relevant code before using browser agents, Playwright, browser-control, or web MCP tools.
- Browser-control tools run only inside the `execute` runtime via `tools["browser-control"]`. Never guess a tool name. After one unknown or unsupported error, switch tools instead of retrying.
- Run the fish function `bon` before you start browser-control work. It sets `disabled: false` in `opencode.jsonc` and connects the MCP server for the current directory. The connect call takes effect in the running session. A restart is not necessary.
- Run `bkill` after the browser-control work is done. It disconnects the MCP server, kills `browser-control-mcp`, and sets `disabled: true` in the config again.
- Treat `bon` and `bkill` as the preferred workflow, not a hard requirement. The `browser-control` skill can drive the browser on its own. Use `/mcps` in the TUI to connect or disconnect the server mid-session. Skip the pair when the MCP server is already connected or the config already enables it.

# ASD-STE100 for technical content

Rewrite technical prose with rules adapted from ASD-STE100 Simplified Technical English. Preserve the facts, intent, useful detail, formatting, and established author voice.

## Choose a mode

- Use **strict** mode for procedures, safety text, error messages, runbooks, and instructions.
- Use **STE-flavored** mode for READMEs, API docs, PR text, release notes, and other general technical prose.
- Use strict mode when the user does not specify a mode and the text tells a reader what to do.
- Use STE-flavored mode for all other requests.

Do not apply these writing rules to code, identifiers, command syntax, or creative writing.
Do not apply them to marketing copy that depends on a distinct voice.

## Apply the workflow

1. Read the full source before editing.
2. Identify facts, requirements, warnings, commands, links, and structural elements that must remain.
3. Rewrite the text with the selected mode.
4. Compare the rewrite with the source. Restore any lost meaning or necessary detail.
5. Return only the requested deliverable unless the user asks for an audit or explanation.

## Use plain words

- Use one name for one thing.
- Use a short common word when it keeps the exact meaning.
- Prefer `start` to `commence`, `use` to `utilize`, `help` to `facilitate`, and `show` to `demonstrate`.
- Give each word one meaning within the document.
- Use American spelling unless the source or user requires another variety.
- Remove empty intensifiers and promotional claims such as `seamless`, `robust`, `powerful`, `cutting-edge`, and `world-class`.
- Keep necessary technical terms. Define an unfamiliar term at its first use.
- Be specific. State your opinion clearly. Speak in the first person.

## Make actors and actions clear

- Use active voice when the actor is known.
- Use a verb for an action. Write `analyze the log`, not `perform an analysis of the log`.
- Prefer a simple tense to an `-ing` main verb.
- Remove stacked auxiliaries and modal hedges.
- State who or what performs each action.
- Preserve passive voice when the actor is unknown, irrelevant, or intentionally withheld.

## Control sentences and structure

- Put one instruction in each sentence.
- In strict mode, keep instructions at 20 words or fewer and descriptions at 25 words or fewer.
- In STE-flavored mode, prefer short sentences but vary length when it improves flow.
- Put a condition before the action it controls.
- Use a numbered vertical list for a sequence.
- Keep one topic in each paragraph and no more than six sentences.
- Replace semicolons with periods or another clear construction.
- Expand contractions in strict mode. Preserve them in STE-flavored mode when they match the author voice.
- Remove fake transitions, padded summaries, vague attributions, and repeated conclusions.

## Preserve substance

- Do not invent evidence, examples, measurements, quotes, or sources. This governs rewrites. Examples, fixtures, and sample content that the user asks you to create are the deliverable, not invented evidence. State your assumptions and continue.
- Do not remove caveats, limitations, warnings, or exceptions to make the text shorter.
- Do not flatten a known author voice into generic corporate prose.
- Do not add personality when neutral technical prose is correct.
- Do not claim that text is human-written or undetectable.

These writing rules improve the form of technical prose. They cannot make weak ideas true or unsupported claims credible.
For creative writing unrelated to technical content, you can ignore these writing rules.

# Forbidden

- Never run a development server. One is always running already.

# Project tools

- Check which package manager and tools the project uses. Use them instead of defaulting to npm.
- For a quick database, use SQLite.

# Git

## Before you work

- Run `git status` before you start. Note which files are already modified or untracked.
- Treat pre-existing changes as the user's work, except edits you made earlier in this session and deferred for batching.
- Never stash, revert, or delete the user's changes.
- Do not stage or commit the user's changes except under the small, same-purpose exception below.

## While you work

- Include small changes by someone else when they serve the same purpose and are in the code you edit.
  Examples include related CSS values or variable names. This is the only exception for committing another person's changes.
- Commit your own work without asking only when it reaches a substantial, meaningful point.
  Examples include a finished feature, a bug fix, a refactor step, or a set of new files.
  A small edit does not require its own commit merely because it completes a task or ends a reply.
- Batch related small edits into a later substantial commit, including across replies in the same session.
  If an edit adds fewer than 100 lines, you may defer its commit.
  When that commit is due, include the deferred edits in it. Do not give a deferred edit its own commit.
  Do not create a commit for each line, small edit, or reply.
- Include your non-code changes, such as skills and docs, in the relevant commit.
- Write a detailed commit message. State what changed and why.
- End every commit message body with this trailer line: `OpenCode: <session name> (<ses_... id>)`. Take both values from your current OpenCode session context. Do not invent a session name. If no tool shows it, read the title for your session ID from the OpenCode state database. If you still cannot read it, use the session ID in the name position.
- Stage files by explicit path only. Do not use `git add .` or `git add -A`.
- Include new files you created in the commit.
- A file can contain both your edits and the user's edits. Stage only your hunks, for example with `git add -p`.
  Include others' hunks only under the small, same-purpose exception above.
- Do not start merges, rebases, or history rewrites on your own.
  Avoid operations that can cause merge or rebase conflicts with the user's uncommitted work.
- When a commit is due, do not wait for permission because the working tree contains other uncommitted changes.
  Commit your share and leave unrelated changes alone.

## Before you finish

- Run `git status` one last time.
- At a substantial milestone, commit all your output for that milestone, including related edits deferred earlier in this session.
- Small-only work may remain uncommitted for batching. An ending reply alone does not require a commit.
- If your accumulated uncommitted work spans 10+ files or 100+ changed lines, commit it before finishing.
- List any deferred edits of your own. List remaining unrelated changes as the user's work, including changes in shared files.
