---
description: Review the last commit for security vulnerabilities using the current codebase
---

Review the following git diff of the last commit for security vulnerabilities.

!`git diff HEAD~1..HEAD`

Focus ONLY on genuine CRITICAL or HIGH severity issues:
- Hardcoded secrets (API keys, passwords, tokens, private keys)
- Command injection with unsanitized user input
- SQL injection
- Path traversal
- Authentication/authorization bypass
- Remote code execution
- Insecure deserialization

List each issue with severity, file, and a description. If you find serious issues, ask if the user wants you to create a fix branch.
