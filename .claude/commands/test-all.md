---
description: Run the harness test suite and the techblogs QA sweep over all reports
allowed-tools: Read, Glob, Bash(bash tests/run-all.sh:*), Bash(python3:*), Bash(find:*), Bash(chmod +x:*), Bash(bash -n:*), Bash(ls:*)
---

# Test All

Execute the full validation suite for this project: harness tests plus
techblogs QA across every published report HTML.

## Step 1: Harness Tests

```bash
bash tests/run-all.sh
```

Validates hooks (existence, permissions, syntax, registration, behavior),
secret-scan patterns (true/false positives), and site structure
(_config.yml exclude list, layouts, CLAUDE.md sections, settings.json).

## Step 2: techblogs QA Sweep

Run QA on every report document:

```bash
find docs/techblog -name '*-report.html' -exec python3 ~/.claude/skills/techblogs/scripts/qa.py {} \;
```

qa.py exits 1 on any ERROR; WARN items are judgement calls - read them and decide.

## Step 3: Report

Present:
- Harness tests: total / passed / failed / skipped
- QA sweep: reports checked, reports with ERROR, notable WARN items
- Failed test details with file paths and error messages
- Suggest fixes for failures if the cause is apparent

## Error Recovery

### If test runner itself fails
```bash
bash -n tests/run-all.sh          # Check syntax
ls -la tests/**/*.sh              # Check permissions
chmod +x tests/run-all.sh         # Fix permissions
```

### Common failure categories and fixes

| Failure Pattern | Likely Cause | Fix |
|---|---|---|
| "file not found" | Missing file after restructure | Create file or update test |
| "invalid JSON" | Malformed settings.json | `python3 -m json.tool .claude/settings.json` |
| "not executable" | Permission reset by git | `chmod +x` on affected files |
| "bash syntax error" | Bad edit in script | `bash -n <file>` to locate error |
| qa.py ERROR | Report violates techblogs rules | Fix the report HTML per the message |

### If many tests fail at once
Likely a structural change broke multiple assumptions:
1. `git log -1` — what was the last change?
2. `git diff HEAD~1` — what specifically changed?
3. Fix the root cause, not individual tests
