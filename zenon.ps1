# Obtener el directorio del script actual
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Ejecutar node reenviando todos los argumentos recibidos
node "$ScriptDir\zenon.js" @args
