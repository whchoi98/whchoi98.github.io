#!/bin/bash
# Structure tests for whchoi98.github.io (Jekyll blog).
# Validates _config.yml exclude list, layouts, CLAUDE.md content,
# settings.json, commands, scripts, and internal doc scaffolding.

# --- Manifest validation ---
assert_json_valid "settings.json is valid JSON" ".claude/settings.json"
assert_json_valid ".mcp.json is valid JSON" ".mcp.json"

# --- _config.yml exclude list (internal docs must never reach the public site) ---
EXCLUDES=("CLAUDE.md" "assets/CLAUDE.md" "docs/CLAUDE.md" "docs/decisions" "docs/runbooks" "docs/reference" "docs/architecture.md" "docs/onboarding.md" "scripts" "tests" "tools" ".editorconfig" ".env.example")
for item in "${EXCLUDES[@]}"; do
    grep -qF "\"$item\"" _config.yml && pass "_config.yml excludes $item" || fail "_config.yml excludes $item" "not found in exclude list"
done

# --- Layouts (site chrome contract) ---
LAYOUTS=(default home post report tags listing about doc)
for layout in "${LAYOUTS[@]}"; do
    assert_file_exists "layout $layout.html exists" "_layouts/$layout.html"
done

# --- Core file existence ---
assert_file_exists "Root CLAUDE.md" "CLAUDE.md"
assert_file_exists "_layouts/CLAUDE.md" "_layouts/CLAUDE.md"
assert_file_exists "assets/CLAUDE.md" "assets/CLAUDE.md"
assert_file_exists "docs/CLAUDE.md" "docs/CLAUDE.md"
assert_file_exists "docs/architecture.md" "docs/architecture.md"
assert_file_exists "docs/onboarding.md" "docs/onboarding.md"
assert_file_exists "docs/reference/security.md" "docs/reference/security.md"
assert_file_exists "docs/reference/INDEX.md" "docs/reference/INDEX.md"
assert_file_exists "ADR template" "docs/decisions/.template.md"
assert_file_exists "Runbook template" "docs/runbooks/.template.md"
assert_file_exists "README.md" "README.md"
assert_file_exists "CHANGELOG.md" "CHANGELOG.md"
assert_file_exists ".env.example" ".env.example"
assert_file_exists ".editorconfig" ".editorconfig"

# --- Script validation ---
assert_file_executable "setup.sh is executable" "scripts/setup.sh"
assert_bash_syntax "setup.sh valid bash" "scripts/setup.sh"
assert_file_executable "install-hooks.sh is executable" "scripts/install-hooks.sh"
assert_bash_syntax "install-hooks.sh valid bash" "scripts/install-hooks.sh"

# --- Skills ---
for skill in code-review refactor release sync-docs; do
    assert_file_exists "skill $skill/SKILL.md" ".claude/skills/$skill/SKILL.md"
done

# --- Agents ---
assert_file_exists "agent code-reviewer.yml" ".claude/agents/code-reviewer.yml"
assert_file_exists "agent security-auditor.yml" ".claude/agents/security-auditor.yml"

# --- Command frontmatter ---
for cmd in review test-all deploy; do
    assert_file_exists "command $cmd.md exists" ".claude/commands/$cmd.md"
    CMD_CONTENT=$(cat ".claude/commands/$cmd.md")
    assert_contains "Command $cmd: has frontmatter" "$CMD_CONTENT" "description:"
    assert_contains "Command $cmd: has allowed-tools" "$CMD_CONTENT" "allowed-tools:"
done

# --- CLAUDE.md content (use grep -F for fixed string matching) ---
SECTIONS=("Overview" "Tech Stack" "Project Structure" "Conventions" "Key Commands" "Auto-Sync Rules")
for section in "${SECTIONS[@]}"; do
    grep -qF "## $section" CLAUDE.md && pass "CLAUDE.md: has $section" || fail "CLAUDE.md: has $section" "not found"
done
grep -qF "AUTO-MANAGED:references" CLAUDE.md && pass "CLAUDE.md: has references marker" || fail "CLAUDE.md: has references marker" "not found"
grep -qF "git add -A" CLAUDE.md && pass "CLAUDE.md: documents git add -A ban" || fail "CLAUDE.md: documents git add -A ban" "not found"

# --- settings.json deny list ---
SETTINGS=$(cat .claude/settings.json)
assert_contains "deny list blocks git add -A" "$SETTINGS" "git add -A"
assert_contains "deny list blocks force push" "$SETTINGS" "git push --force"
assert_contains "deny list blocks rm -rf" "$SETTINGS" "rm -rf"
