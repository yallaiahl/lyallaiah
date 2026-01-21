# Persistent RobotMCP startup script
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\start_mcp_server.ps1

$repoRoot = Split-Path -Parent $PSScriptRoot
$pythonPath = Join-Path $repoRoot ".venv\Scripts\python.exe"
if (-not (Test-Path $pythonPath)) {
  Write-Host "Python not found at $pythonPath — falling back to 'python' in PATH" -ForegroundColor Yellow
  $pythonPath = "python"
}

# Environment variables for RobotMCP (edit if needed)
$env:ROBOTMCP_ATTACH_HOST = "127.0.0.1"
$env:ROBOTMCP_ATTACH_PORT = "7317"
$env:ROBOTMCP_ATTACH_TOKEN = "change-me"
$env:ROBOTMCP_ATTACH_DEFAULT = "auto"

# Loop forever and restart the server if it exits
while ($true) {
  Write-Host "Starting RobotMCP using $pythonPath -m robotmcp.server" -ForegroundColor Green
  & $pythonPath -u -m robotmcp.server
  $exit = $LASTEXITCODE
  Write-Host "RobotMCP exited (code=$exit). Restarting in 3 seconds..." -ForegroundColor Cyan
  Start-Sleep -Seconds 3
}
