@echo off
setlocal enabledelayedexpansion

echo Checking if GREEN is healthy...

:: Kill any running Python app
taskkill /f /im python.exe >nul 2>&1

:: Switch symlink to green
rmdir live 2>nul
mklink /D live deploy\green

:: Start green
start "GREEN" python live\app.py
ping -n 3 127.0.0.1 >nul

:: Health check
curl -s http://localhost:5000/health >nul
if !errorlevel! neq 0 (
    echo [ERROR] GREEN failed - initiating rollback...
    call rollback.bat
    exit /b 1
)

echo [SUCCESS] GREEN is now LIVE!
start "" http://localhost:5000
pause
