---
description: Run code review on current changes with confidence-based filtering
allowed-tools: Read, Glob, Grep, Bash(git diff:*), Bash(git log:*), Bash(git status:*)
---

# Code Review

Review the current code changes using confidence-based scoring and the
code-review skill criteria (.claude/skills/code-review/SKILL.md).

## Step 1: Get Changes

Determine the scope of review:

- If $ARGUMENTS specifies files, review those files
- Otherwise, review unstaged changes: `git diff`
- If no unstaged changes, review staged changes: `git diff --cached`

## Step 2: Review

For each changed file, apply the code-review skill criteria:
- Project guidelines compliance (report 패턴, KO/EN 동등성, CSS 변수, git add -A 금지)
- Bug detection (Liquid errors, front matter mistakes, broken links, JS logic)
- Code quality (duplication, accessibility, techblogs QA compliance)

## Step 3: Score and Filter

Rate each issue 0-100. Only report issues with confidence >= 75.

## Step 4: Output

Present findings in structured format with file paths, line numbers, and fix suggestions.
If no high-confidence issues, confirm code meets standards.

## Error Recovery

### If no changes found (Step 1)
No diff output means nothing to review. Inform the user:
- Check if changes are committed: `git log -1 --oneline`
- Check if on the right branch: `git branch --show-current`
- Suggest specifying files directly: `/review path/to/file`

### If CLAUDE.md is missing or empty (Step 2)
Cannot evaluate project guidelines without CLAUDE.md. Suggest:
- Restore CLAUDE.md from git history
- Or create a minimal CLAUDE.md with conventions section

### If diff is too large (>500 lines)
Focus on high-risk files first:
1. Site chrome changes (_layouts/, _includes/, assets/) - affect every page
2. _config.yml changes - exclude list and category metadata
3. New report HTML (run techblogs QA instead of line-by-line review)
4. Documentation changes (lower priority)
