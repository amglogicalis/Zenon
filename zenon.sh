#!/usr/bin/env bash

# Obtener el directorio absoluto donde está el script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ejecutar zenon.js reenviando todos los argumentos recibidos
node "$SCRIPT_DIR/zenon.js" "$@"
