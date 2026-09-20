#!/bin/bash
# Build the offline ZIP of the Claude Code workshop lab pages.
# Usage: bash scripts/build-lab-zip.sh   (run from the repo root after syncing ccw-hands-on-lab/)
# Output: ccw-hands-on-lab/ClaudeCode_Workshop_HandsOnLab.zip, force-included in _config.yml.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LAB="$ROOT/ccw-hands-on-lab"
NAME="ClaudeCode_Workshop_HandsOnLab"
OUT="$LAB/$NAME.zip"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/$NAME"
# Top-level pages, START_HERE.txt and the shared assets; the v1/ archive and any zip are left out.
cp "$LAB"/*.html "$LAB"/START_HERE.txt "$STAGE/$NAME/"
cp -R "$LAB/assets" "$STAGE/$NAME/assets"

# The toolbar ZIP button points at this archive, which does not exist inside the offline copy: strip it.
python3 - "$STAGE/$NAME" <<'PY'
import pathlib, re, sys
for p in pathlib.Path(sys.argv[1]).glob('*.html'):
    s = p.read_text(encoding='utf-8')
    s2 = re.sub(r'[ \t]*<!-- zip-download -->.*?<!-- /zip-download -->\n?', '', s, flags=re.S)
    if s2 != s:
        p.write_text(s2, encoding='utf-8')
PY

rm -f "$OUT"
(cd "$STAGE" && zip -qr -X "$OUT" "$NAME")
echo "built $OUT ($(du -h "$OUT" | cut -f1), $(unzip -l "$OUT" | tail -1 | awk '{print $2}') entries)"
