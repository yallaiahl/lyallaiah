<#
Setup script for Appium + Robot Framework environment (Windows).

What it does:
- Installs Python packages from `requirements.txt` using `python -m pip`.
- If `npm` is available, installs Appium globally (`npm install -g appium`).
- Checks for presence of Java, Android `adb`/`emulator`, `node`/`npm` and prints guidance.

Run as an Administrator or a user with permission to install global npm packages.
Usage:
  powershell -ExecutionPolicy Bypass -File .\scripts\setup_appium.ps1
#>

Set-StrictMode -Version Latest

Write-Host "Starting Appium environment setup..." -ForegroundColor Cyan

function Check-Command($name) {
    $cmd = Get-Command $name -ErrorAction SilentlyContinue
    return $null -ne $cmd
}

function Run-If-Exists($exe, $args) {
    if (Check-Command $exe) {
        & $exe $args
        return $true
    }
    return $false
}

# 1) Check Node/NPM
if (Check-Command node -or Check-Command npm) {
    Write-Host "Node/NPM detected. Installing Appium via npm (may require admin rights)..." -ForegroundColor Green
    try {
        npm install -g appium
        Write-Host "Appium installed (or already present)." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install Appium globally. Rerun with admin rights or install Appium Desktop manually." -ForegroundColor Yellow
    }
} else {
    Write-Host "Node.js / npm not found. Please install Node.js from https://nodejs.org/ and re-run this script to install the Appium server." -ForegroundColor Yellow
}

# 2) Check Java
if (Check-Command java) {
    Write-Host "Java detected." -ForegroundColor Green
} else {
    Write-Host "Java JDK not found. Install Java JDK (11+) and set JAVA_HOME." -ForegroundColor Yellow
}

# 3) Check Android tools
if (Check-Command adb) {
    Write-Host "adb found." -ForegroundColor Green
} else {
    Write-Host "adb not found. Ensure Android SDK platform-tools are installed and on PATH." -ForegroundColor Yellow
}

if (Check-Command emulator) {
    Write-Host "Android emulator tool found." -ForegroundColor Green
} else {
    Write-Host "Android emulator tool not found. Ensure Android SDK emulator is installed and on PATH." -ForegroundColor Yellow
}

# 4) Install Python packages from requirements.txt (use script directory to locate file)
if (Check-Command python) {
    Write-Host "Installing Python packages from requirements.txt into active Python environment..." -ForegroundColor Green
    try {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
        $reqPath = Join-Path $scriptDir "..\requirements.txt"
        $reqPathResolved = Resolve-Path $reqPath -ErrorAction Stop
        python -m pip install --upgrade pip
        python -m pip install -r "$($reqPathResolved.Path)"
        Write-Host "Python packages installed." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install Python packages. You may run: python -m pip install -r requirements.txt (from repo root)" -ForegroundColor Red
    }
} else {
    Write-Host "Python not found. Install Python 3.8+ and ensure 'python' is on PATH." -ForegroundColor Yellow
}

Write-Host "\nSetup summary:" -ForegroundColor Cyan
Write-Host "- If any components are missing, follow the guidance above." -ForegroundColor Cyan
Write-Host "- To start Appium server locally run: appium" -ForegroundColor Cyan
Write-Host "- To run example Robot tests: robot --pythonpath src tests/user_appium_example.robot" -ForegroundColor Cyan

Write-Host "Setup script finished." -ForegroundColor Cyan
