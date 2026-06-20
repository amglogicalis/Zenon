#!/usr/bin/env bash
# =============================================================================
# Zenon AI Engine — CLI wrapper (Linux / macOS)
# Usage:
#   ./zenon.sh                           # default: assist mode
#   ./zenon.sh --mode correct            # auto-fix & commit
#   ./zenon.sh --mode objective          # implement goal from zenon_objective.md
#   ./zenon.sh --mode objective --objective path/to/my_goal.md
#   ./zenon.sh --mode assist --exclude "test/,fixtures/"
#   ./zenon.sh --mode trainer --topic "Ruby on Rails 7.0"
#   ./zenon.sh --mode reviewer           # review local unstaged/staged git diff
#   ./zenon.sh --mode reviewer --diff "HEAD~1" # review last commit
#   ./zenon.sh --mode analyzer           # show consumption stats and quotas
#   ./zenon.sh --mode analyzer --reset-stats # reset consumption statistics
#   ./zenon.sh --mode helper --topic "¿cómo funciona la autenticación?"
#   ./zenon.sh --mode updater            # auto-update docs relative to code changes
#   ./zenon.sh --mode updater --docs "README.md" # update specific documentation files
#   ./zenon.sh --mode tester             # detect tests, run and report errors
#   ./zenon.sh --mode tester --auto-fix  # run tests and auto-fix/commit changes
#   ./zenon.sh --mode tester --test-cmd "npm test" # run tests with custom command
#   ./zenon.sh --mode tester --topic "auth.test.js" # run tests focusing on auth.test.js
#
#   ---- Zenon DevOpser — Autonomous DevOps Operator & Lambda Platform ----
#   ./zenon.sh --mode devops                                    # run all tasks in zenon_devops.md
#   ./zenon.sh --mode devops --plan-file my_pipeline.md         # custom plan file
#   ./zenon.sh --mode devops --devops-task "check-ssl"          # run only a specific task
#   ./zenon.sh --mode devops --self-heal                        # enable AI self-healing on failures
#   ./zenon.sh --mode devops --notify-webhook "https://discord.com/api/webhooks/..."   # notify Discord
#   ./zenon.sh --mode devops --notify-email "you@example.com"   # set email report target
#   ./zenon.sh --mode devops --self-heal --devops-task "my-task" # targeted + self-heal
# =============================================================================
set -euo pipefail

# Resolve the directory where this script lives (supporting symlinks)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
SRC_DIR="$SCRIPT_DIR/src"
ZENON_JS="$SRC_DIR/zenon.js"
MODELS_JSON="$SRC_DIR/zenon_models.json"

# Verify and download dependencies if missing
if [ ! -d "$SRC_DIR" ]; then
  mkdir -p "$SRC_DIR"
fi

if [ ! -f "$ZENON_JS" ]; then
  echo -e "\033[0;33m[zenon.sh] 📥 Descargando 'zenon.js' desde el repositorio principal...\033[0m"
  if command -v curl &> /dev/null; then
    curl -fsSL -o "$ZENON_JS" "https://raw.githubusercontent.com/amglogicalis/Zenon/main/src/zenon.js"
  elif command -v wget &> /dev/null; then
    wget -q -O "$ZENON_JS" "https://raw.githubusercontent.com/amglogicalis/Zenon/main/src/zenon.js"
  else
    echo -e "\033[0;31m❌ Error: Se requiere curl o wget para descargar dependencias.\033[0m" >&2
    exit 1
  fi
fi

if [ ! -f "$MODELS_JSON" ]; then
  echo -e "\033[0;33m[zenon.sh] 📥 Descargando 'zenon_models.json' desde el repositorio principal...\033[0m"
  if command -v curl &> /dev/null; then
    curl -fsSL -o "$MODELS_JSON" "https://raw.githubusercontent.com/amglogicalis/Zenon/main/src/zenon_models.json"
  elif command -v wget &> /dev/null; then
    wget -q -O "$MODELS_JSON" "https://raw.githubusercontent.com/amglogicalis/Zenon/main/src/zenon_models.json"
  else
    echo -e "\033[0;31m❌ Error: Se requiere curl o wget para descargar dependencias.\033[0m" >&2
    exit 1
  fi
fi

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
