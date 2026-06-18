#!/usr/bin/env bash
# =============================================================================
# Zenon AI Engine — CLI wrapper (Linux / macOS)
# Usage:
#   ./zenon.sh                           # default: assist mode
#   ./zenon.sh --mode correct            # auto-fix & commit
#   ./zenon.sh --mode objective          # implement goal from zenon_objective.md
#   ./zenon.sh --mode objective --objective path/to/my_goal.md
#   ./zenon.sh --mode assist --exclude "test/,fixtures/"
# =============================================================================
set -euo pipefail

# Resolve the directory where this script lives (the repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZENON_JS="$SCRIPT_DIR/zenon.js"

# Source a local .env file if it exists (for local API keys)
ENV_FILE="$SCRIPT_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  # Export each non-comment, non-empty line
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
  echo "[zenon.sh] Loaded environment from .env"
fi

# Validate Node.js availability
if ! command -v node &> /dev/null; then
  echo "[zenon.sh] ❌ Node.js is not installed or not on PATH." >&2
  echo "           Install Node.js >= 18 from https://nodejs.org" >&2
  exit 1
fi

NODE_VER=$(node --version)
echo "[zenon.sh] Node.js $NODE_VER detected"
echo "[zenon.sh] Launching Zenon AI Engine..."
echo ""

# Forward all CLI arguments to zenon.js
node "$ZENON_JS" "$@"
