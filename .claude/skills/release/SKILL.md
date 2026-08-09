# Release Skill

Automate the site release process with validation checks.
This project has no version tags or version files - a "release" is a verified
deployment: main push -> GitHub Actions -> GitHub Pages.

## Procedure

### 1. Pre-release Checks
- Verify working tree state: `git status` (only intended files staged; never `git add -A`)
- Local build must succeed:

```bash
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll build -d _site
```

- Harness tests pass: `bash tests/run-all.sh`
- New/changed reports pass techblogs QA:

```bash
python3 ~/.claude/skills/techblogs/scripts/qa.py docs/techblog/<category>/<slug>-report.html
```

- Confirm internal docs are NOT in `_site/` (exclude list intact):

```bash
ls _site/CLAUDE.md _site/scripts _site/tests 2>&1 | grep -q "No such" && echo "OK: internal docs excluded"
```

### 2. Review Changes Since Last Deploy
- `git log origin/main..HEAD --oneline` - what will this push publish?
- Group by content (new posts, workshop updates) vs chrome (layout/CSS/JS)

### 3. Update Changelog
- Add entries to the `[Unreleased]` section of CHANGELOG.md
- Group by type (Added, Changed, Fixed) in both language sections
- Meaningful units only - no raw commit copy-paste

### 4. Deploy
- Commit with Conventional Commits message (feat:, fix:, docs:)
- `git push origin main` - GitHub Actions builds and deploys to Pages
- No tags are created (this project does not version releases)

### 5. Verify and Summarize
- Check the Actions run: `gh run watch` or the repository Actions tab
- Spot-check https://whchoi98.github.io after deploy completes
- Display: what was published, QA results, Actions run status
