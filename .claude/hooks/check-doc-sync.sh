#!/bin/bash
# Detect documentation sync needs after file changes.
# Triggered by PostToolUse (Write|Edit) events.
# Walks parent directories to find CLAUDE.md before warning.
# Adapted for this Jekyll blog: watches _layouts/, assets/, docs/techblog/
# instead of src/ (this project has no application source tree).

FILE_PATH="${1:-}"
[ -z "$FILE_PATH" ] && exit 0

# Source roots for this project (Jekyll blog)
SOURCE_ROOTS="_layouts assets docs/techblog"

for ROOT in $SOURCE_ROOTS; do
    if [[ "$FILE_PATH" == ${ROOT}/* ]]; then
        DIR=$(dirname "$FILE_PATH")
        FOUND_CLAUDE=false
        CHECK_DIR="$DIR"
        # Walk up to the repository root ("." ) so that docs/CLAUDE.md
        # covers docs/techblog/* and assets/CLAUDE.md covers assets/*.
        while [ "$CHECK_DIR" != "." ] && [ -n "$CHECK_DIR" ]; do
            if [ -f "$CHECK_DIR/CLAUDE.md" ]; then
                FOUND_CLAUDE=true
                break
            fi
            CHECK_DIR=$(dirname "$CHECK_DIR")
        done
        if ! $FOUND_CLAUDE; then
            echo "[doc-sync] No CLAUDE.md found covering $DIR. Create module documentation."
        fi
        break
    fi
done

# Alert if no ADRs exist when site chrome or architecture files change
IS_SOURCE=false
for ROOT in $SOURCE_ROOTS; do
    [[ "$FILE_PATH" == ${ROOT}/* ]] && IS_SOURCE=true && break
done
if $IS_SOURCE || [[ "$FILE_PATH" == docs/architecture.md ]]; then
    ADR_COUNT=$(find docs/decisions -name 'ADR-*.md' -not -name '.template.md' 2>/dev/null | wc -l)
    if [ "$ADR_COUNT" -eq 0 ]; then
        echo "[doc-sync] No ADRs found. Record architectural decisions."
    fi
fi

# Alert if no runbooks exist when build/deploy pipeline files change
if [[ "$FILE_PATH" == _config.yml ]] || [[ "$FILE_PATH" == Gemfile ]] || [[ "$FILE_PATH" == .github/workflows/* ]]; then
    RUNBOOK_COUNT=$(find docs/runbooks -name '*.md' -not -name '.template.md' 2>/dev/null | wc -l)
    if [ "$RUNBOOK_COUNT" -eq 0 ]; then
        echo "[doc-sync] No runbooks found. Create operational runbooks for build/deploy/recovery."
    fi
fi
