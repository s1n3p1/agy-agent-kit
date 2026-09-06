#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/.gemini"
KIT="$BASE/config/agy-agent-kit"
SKILLS="$BASE/config/skills"
errors=0

ok() { printf '✓ %s\n' "$1"; }
fail() { printf '✗ %s\n' "$1" >&2; errors=$((errors+1)); }

if [ -f "$BASE/GEMINI.md" ] && grep -Fq '<!-- AGY-AGENT-KIT:BEGIN -->' "$BASE/GEMINI.md" && grep -Fq '<!-- AGY-AGENT-KIT:END -->' "$BASE/GEMINI.md"; then
  ok "global bootstrap marker"
else
  fail "global bootstrap marker missing from $BASE/GEMINI.md"
fi

for f in \
  02-session.md \
  10-cli-server.md \
  11-git.md \
  20-coding.md \
  21-tech-stack.md \
  30-security.md \
  40-language-ko.md \
  50-memory.md
  do
    [ -f "$KIT/rules/$f" ] && ok "rule $f" || fail "rule $f"
  done

for s in \
  agy-kit-bug-investigation \
  agy-kit-feature-implementation \
  agy-kit-frontend-ui \
  agy-kit-refactor \
  agy-kit-research \
  agy-kit-server-ops
  do
    [ -f "$SKILLS/$s/SKILL.md" ] && ok "skill $s" || fail "skill $s"
  done

if [ "$errors" -ne 0 ]; then
  echo
  echo "$errors verification check(s) failed." >&2
  exit 1
fi

echo
echo "Filesystem verification passed."
echo "Open a NEW agy session for runtime discovery verification."
