#!/bin/bash
# Load project context at Claude Code session start.
# Outputs key project information for immediate context.

echo "=== Project Context ==="

# Project type detection (this repo is a Jekyll site)
if [ -f "_config.yml" ] && [ -f "Gemfile" ]; then
    TITLE=$(grep -m1 '^title:' _config.yml | sed 's/^title:[[:space:]]*//')
    echo "Project: ${TITLE:-$(basename $(pwd))} (Jekyll / GitHub Pages)"
elif [ -f "package.json" ]; then
    NAME=$(python3 -c "import json; print(json.load(open('package.json')).get('name',''))" 2>/dev/null)
    echo "Project: $NAME (Node.js)"
else
    echo "Project: $(basename $(pwd))"
fi

# Content stats
POST_COUNT=$(find docs/techblog -name '*-report.html' 2>/dev/null | wc -l | tr -d ' ')
WORKSHOP_COUNT=$(find docs/workshop -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
echo "Content: $POST_COUNT report(s), $WORKSHOP_COUNT workshop doc(s)"

# Recent activity
LAST_COMMIT=$(git log -1 --format="%h %s (%cr)" 2>/dev/null)
[ -n "$LAST_COMMIT" ] && echo "Last commit: $LAST_COMMIT"

# Branch info
BRANCH=$(git branch --show-current 2>/dev/null)
[ -n "$BRANCH" ] && echo "Branch: $BRANCH"

# Uncommitted changes
CHANGES=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
[ "$CHANGES" -gt 0 ] && echo "Uncommitted changes: $CHANGES file(s)"

# Documentation status
CLAUDE_COUNT=$(find . -name "CLAUDE.md" -not -path "./.git/*" -not -path "./_site/*" -not -path "./vendor/*" 2>/dev/null | wc -l | tr -d ' ')
echo "CLAUDE.md files: $CLAUDE_COUNT"

echo "======================"
