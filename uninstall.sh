#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/.gemini"
GEMINI="$BASE/GEMINI.md"
KIT="$BASE/config/agy-agent-kit"
SKILLS="$BASE/config/skills"

if [ -f "$GEMINI" ]; then
  tmp="$(mktemp)"
  awk '
    /<!-- AGY-AGENT-KIT:BEGIN -->/ {skip=1; next}
    /<!-- AGY-AGENT-KIT:END -->/   {skip=0; next}
    !skip {print}
  ' "$GEMINI" > "$tmp"
  mv "$tmp" "$GEMINI"
fi

rm -rf "$KIT"
for s in \
  agy-kit-bug-investigation \
  agy-kit-feature-implementation \
  agy-kit-frontend-ui \
  agy-kit-refactor \
  agy-kit-research \
  agy-kit-server-ops
  do rm -rf "$SKILLS/$s"; done

echo "AGY Agent Kit core configuration removed."
echo "Upstream plugins/skills were intentionally left installed."
echo "Backups, if any, remain under $BASE/agy-agent-kit-backups/."
