# =============================================================================
# Zenon AI Engine — CLI wrapper (Windows / PowerShell)
# Usage:
#   .\zenon.ps1                                      # default: assist mode
#   .\zenon.ps1 --mode correct                       # auto-fix & commit
#   .\zenon.ps1 --mode objective                     # implement goal from zenon_objective.md
#   .\zenon.ps1 --mode objective --objective path\to\my_goal.md
#   .\zenon.ps1 --mode assist --exclude "test/,fixtures/"
# =============================================================================
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ZenonArgs
)

$ErrorActionPreference = "Stop"

# Resolve the directory where this script lives (the repo root)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ZenonJs   = Join-Path $ScriptDir "zenon.js"

# Load a local .env file if it exists (for local API keys)
$EnvFile = Join-Path $ScriptDir ".env"
if (Test-Path $EnvFile) {
    Write-Host "[zenon.ps1] Loading environment from .env..."
    Get-Content $EnvFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#")) {
            $parts = $line -split "=", 2
            if ($parts.Count -eq 2) {
                $key   = $parts[0].Trim()
                $value = $parts[1].Trim().Trim('"').Trim("'")
                [System.Environment]::SetEnvironmentVariable($key, $value, "Process")
            }
        }
    }
    Write-Host "[zenon.ps1] Environment loaded."
}

# Validate Node.js availability
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeCmd) {
    Write-Error "[zenon.ps1] ❌ Node.js is not installed or not on PATH.`n           Install Node.js >= 18 from https://nodejs.org"
    exit 1
}

$nodeVer = & node --version
Write-Host "[zenon.ps1] Node.js $nodeVer detected"
Write-Host "[zenon.ps1] Launching Zenon AI Engine..."
Write-Host ""

# Forward all CLI arguments to zenon.js
& node $ZenonJs @ZenonArgs
