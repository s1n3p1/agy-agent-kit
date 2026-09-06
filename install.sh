#!/usr/bin/env bash
set -euo pipefail

REPO="s1n3p1/agy-agent-kit"
REF="${AGY_AGENT_KIT_REF:-main}"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/${REF}"
GEMINI_DIR="${HOME}/.gemini"
CONFIG_DIR="${GEMINI_DIR}/config"
KIT_DIR="${CONFIG_DIR}/agy-agent-kit"
RULES_DIR="${KIT_DIR}/rules"
SKILLS_DIR="${CONFIG_DIR}/skills"
BACKUP_ROOT="${GEMINI_DIR}/agy-agent-kit-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${BACKUP_ROOT}/${STAMP}"
NO_PLUGINS=0

for arg in "$@"; do
  case "$arg" in
    --no-plugins|--core-only) NO_PLUGINS=1 ;;
    -h|--help)
      cat <<'EOF'
AGY Agent Kit installer

Usage:
  install.sh [--no-plugins]

Options:
  --no-plugins, --core-only   Install only AGY Agent Kit rules and core skills.
EOF
      exit 0
      ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

need() {
  command -v "$1" >/dev/null 2>&1 || { echo "ERROR: required command not found: $1" >&2; exit 1; }
}

need curl
need awk
need mktemp
need cp
need mkdir
need rm

if ! command -v agy >/dev/null 2>&1; then
  echo "ERROR: Antigravity CLI (agy) is not installed or not in PATH." >&2
  echo "Install it first: curl -fsSL https://antigravity.google/cli/install.sh | bash" >&2
  exit 1
fi

mkdir -p "$RULES_DIR" "$SKILLS_DIR" "$BACKUP_DIR"

fetch() {
  local path="$1"
  local out="$2"
  curl -fsSL --retry 3 --retry-delay 1 "${RAW_BASE}/${path}" -o "$out"
}

backup_path() {
  local src="$1"
  [ -e "$src" ] || return 0
  local rel="${src#${GEMINI_DIR}/}"
  mkdir -p "${BACKUP_DIR}/$(dirname "$rel")"
  cp -a "$src" "${BACKUP_DIR}/${rel}"
}

remove_managed_block() {
  local src="$1"
  local dst="$2"
  if [ ! -f "$src" ]; then
    : > "$dst"
    return
  fi
  awk '
    /<!-- AGY-AGENT-KIT:BEGIN -->/ {skip=1; next}
    /<!-- AGY-AGENT-KIT:END -->/   {skip=0; next}
    !skip {print}
  ' "$src" > "$dst"
}

printf '\n== AGY Agent Kit ==\n'
echo "Target: $GEMINI_DIR"

# Back up only paths the kit manages.
backup_path "$GEMINI_DIR/GEMINI.md"
backup_path "$KIT_DIR"
for s in \
  agy-kit-bug-investigation \
  agy-kit-feature-implementation \
  agy-kit-frontend-ui \
  agy-kit-refactor \
  agy-kit-research \
  agy-kit-server-ops
  do backup_path "$SKILLS_DIR/$s"; done

# Build the always-loaded GEMINI.md block while preserving pre-existing content.
tmp_existing="$(mktemp)"
tmp_block="$(mktemp)"
tmp_final="$(mktemp)"
trap 'rm -f "$tmp_existing" "$tmp_block" "$tmp_final"' EXIT

remove_managed_block "$GEMINI_DIR/GEMINI.md" "$tmp_existing"
fetch "config/GEMINI.block.md" "$tmp_block"

shared_imports=""
if [ -f "$HOME/.agents/AGENTS.md" ]; then
  shared_imports="${shared_imports}@${HOME}/.agents/AGENTS.md\n"
fi
if [ -f "$HOME/AGENTS.md" ]; then
  shared_imports="${shared_imports}@${HOME}/AGENTS.md\n"
fi

awk -v imports="$(printf '%b' "$shared_imports")" '
  $0 == "@@SHARED_IMPORTS@@" {printf "%s", imports; next}
  {print}
' "$tmp_block" > "${tmp_block}.rendered"

cat "$tmp_existing" > "$tmp_final"
if [ -s "$tmp_existing" ]; then printf '\n' >> "$tmp_final"; fi
cat "${tmp_block}.rendered" >> "$tmp_final"
mv "$tmp_final" "$GEMINI_DIR/GEMINI.md"
rm -f "${tmp_block}.rendered"

# Install routed rules.
for f in \
  02-session.md \
  10-cli-server.md \
  11-git.md \
  20-coding.md \
  21-tech-stack.md \
  30-security.md \
  40-language-ko.md \
  50-memory.md
  do fetch "config/rules/$f" "$RULES_DIR/$f"; done

# Install namespaced core skills.
for s in \
  agy-kit-bug-investigation \
  agy-kit-feature-implementation \
  agy-kit-frontend-ui \
  agy-kit-refactor \
  agy-kit-research \
  agy-kit-server-ops
  do
    mkdir -p "$SKILLS_DIR/$s"
    fetch "skills/$s/SKILL.md" "$SKILLS_DIR/$s/SKILL.md"
  done

install_plugin_or_fallback() {
  local label="$1"
  local url="$2"
  shift 2
  local temp=""

  echo "→ $label"
  if agy plugin install "$url" >/tmp/agy-agent-kit-plugin.log 2>&1; then
    echo "  installed as AGY plugin"
    return 0
  fi

  echo "  AGY plugin install was unavailable; trying skill fallback"
  if ! command -v git >/dev/null 2>&1; then
    echo "  WARNING: git not found; skipped fallback for $label"
    return 0
  fi

  temp="$(mktemp -d)"
  if ! git clone --depth 1 -q "$url" "$temp/repo"; then
    echo "  WARNING: failed to fetch $url"
    rm -rf "$temp"
    return 0
  fi

  local spec src dest
  for spec in "$@"; do
    src="${spec%%:*}"
    dest="${spec#*:}"
    if [ -d "$temp/repo/$src" ]; then
      rm -rf "$SKILLS_DIR/$dest"
      cp -a "$temp/repo/$src" "$SKILLS_DIR/$dest"
      echo "  installed fallback skill: $dest"
    fi
  done
  rm -rf "$temp"
}

if [ "$NO_PLUGINS" -eq 0 ]; then
  echo
  echo "Installing/enabling recommended upstream integrations..."

  install_plugin_or_fallback \
    "Modern Web Guidance" \
    "https://github.com/GoogleChrome/modern-web-guidance" \
    "skills/modern-web-guidance:modern-web-guidance" \
    "skills/chrome-extensions:chrome-extensions"

  install_plugin_or_fallback \
    "Gemini API skills" \
    "https://github.com/google-gemini/gemini-skills" \
    "skills/gemini-api-dev:gemini-api-dev" \
    "skills/gemini-live-api-dev:gemini-live-api-dev" \
    "skills/gemini-interactions-api:gemini-interactions-api" \
    "skills/gemini-omni-flash-api:gemini-omni-flash-api"

  install_plugin_or_fallback \
    "Chrome DevTools" \
    "https://github.com/ChromeDevTools/chrome-devtools-mcp" \
    "skills/a11y-debugging:a11y-debugging" \
    "skills/chrome-devtools:chrome-devtools" \
    "skills/debug-optimize-lcp:debug-optimize-lcp" \
    "skills/memory-leak-debugging:memory-leak-debugging" \
    "skills/troubleshooting:troubleshooting"

  install_plugin_or_fallback \
    "Google Antigravity SDK" \
    "https://github.com/Google-Antigravity/antigravity-sdk-python" \
    "skills/google-antigravity-sdk:google-antigravity-sdk"

  install_plugin_or_fallback \
    "Google Maps Platform" \
    "https://github.com/googlemaps/agent-skills" \
    "skills/google-maps-platform:google-maps-platform"
fi

# Store install metadata without touching AGY's own settings/config.json.
cat > "$KIT_DIR/install-info" <<EOF
repo=$REPO
ref=$REF
installed_at=$STAMP
backup=$BACKUP_DIR
EOF

echo
echo "Running filesystem verification..."
curl -fsSL "${RAW_BASE}/verify.sh" | bash

echo
echo "Done. Start a NEW agy session to load the updated global configuration."
echo "Backup: $BACKUP_DIR"
