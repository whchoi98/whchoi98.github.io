# Sync Docs Skill

Synchronize project documentation with current code state.

## Actions

### 1. Quality Assessment
Score each CLAUDE.md file (0-100) across:
- Commands/workflows (20 pts)
- Architecture clarity (20 pts)
- Non-obvious patterns (15 pts)
- Conciseness (15 pts)
- Currency (15 pts)
- Actionability (15 pts)

Apply anti-pattern deductions:
- Over 500 lines (-15)
- Vague instructions (-10)
- Duplicated docs (-10)
- No test guidance (-10)
- Contains secrets (-20)

Output quality report with grades (A-F) before making changes.

### 2. Root CLAUDE.md Sync
- Update Overview, Tech Stack, Conventions, Key Commands
- Verify commands are copy-paste ready (jekyll build/serve, qa.py, tests/run-all.sh)

### 3. Architecture Doc Sync
- Update docs/architecture.md to reflect current layouts, categories, and pipeline
- Check: `_config.yml` blog_categories vs docs/techblog/ directories vs architecture doc

### 4. Module CLAUDE.md Audit
Module docs for this project (not src/):
- `_layouts/CLAUDE.md` - one entry per layout file; flag added/removed layouts
- `assets/CLAUDE.md` - css/js/icons roles; flag new icons not in blog_categories
- `docs/CLAUDE.md` - content structure and publishing conventions; flag new categories
Score each and update if out of date.

### 5. ADR and Runbook Audit
- Check recent commits for undocumented decisions (theme changes, pipeline changes)
- Verify runbook coverage: local build failure recovery, Pages deploy failure
- Flag stale ADRs and outdated runbooks

### 6. README.md / CHANGELOG.md Sync
- README Project Structure section matches actual directory layout
- CHANGELOG [Unreleased] reflects meaningful changes since last update
- Both language sections stay in sync (writing-style-guide rules)

### 7. Report
Output before/after quality scores, anti-patterns detected, and list of all changes.
