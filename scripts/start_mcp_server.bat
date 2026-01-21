@echo off
REM Starts the persistent PowerShell script (hidden window if launched via a scheduler)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_mcp_server.ps1"
