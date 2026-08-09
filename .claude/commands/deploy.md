---
description: Verify the local Jekyll build, then push to main so GitHub Actions deploys to Pages
allowed-tools: Read, Glob, Bash(bundle exec jekyll build:*), Bash(git status:*), Bash(git log:*), Bash(git push:*), Bash(bash tests/run-all.sh:*), Bash(ls:*), Bash(gh run:*)
---

# Deploy

Deployment for this site is a push to main: GitHub Actions
(.github/workflows/pages-deploy.yml) builds the site and publishes to GitHub Pages.
This command only verifies and pushes - it never builds in CI's place.

## Step 1: Pre-Deploy Checks

1. Verify working tree: `git status` - everything intended must already be committed
2. Verify current branch is `main` (warn otherwise; Pages only deploys from main)
3. Run harness tests: `bash tests/run-all.sh`
4. Local build must succeed:

```bash
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll build -d _site
```

5. Confirm internal docs are excluded from the build output:

```bash
ls _site/CLAUDE.md _site/scripts _site/tests _site/docs/decisions 2>&1
# expected: "No such file or directory" for every path
```

## Step 2: Push (= Deploy)

```bash
git push origin main
```

Note: the workflow ignores pushes that only touch .gitignore, README.md, LICENSE.

## Step 3: Verify

- Watch the Actions run: `gh run watch` (or check the repository Actions tab)
- After success, spot-check https://whchoi98.github.io (new post visible, toggles work)

## Step 4: Summary

Display:
- Commits published (git log of the pushed range)
- Build verification results
- Actions run status and site URL

## Error Recovery

### If pre-deploy checks fail (Step 1)
- Dirty tree: commit intended files explicitly (never `git add -A`) or stash the rest
- Build failure: read the Jekyll error; usual suspects are Liquid syntax in new
  content and unquoted dates in front matter

### If the Actions run fails (Step 3)
- `gh run view --log-failed` for the failing step
- Ruby setup failures: check Gemfile.lock compatibility (CI uses Ruby 3.3)
- Fix forward with a new commit; do not force-push

### If a bad version was published — rollback
```bash
git revert <bad-commit-sha>
git push origin main
```
Actions redeploys the reverted state. Never use `git reset --hard` + force push on main.
