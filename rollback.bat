@echo off
setlocal enabledelayedexpansion

echo Rolling back to BLUE...

:: Kill any running Python app
taskkill /f /im python.exe >nul 2>&1

:: Switch symlink to blue
rmdir live 2>nul
mklink /D live deploy\blue

:: Restart blue
start "BLUE" python live\app.py
:: Wait longer for app to start
ping -n 10 127.0.0.1 >nul

:: Verify
curl -s http://localhost:5000/health >nul
if !errorlevel! neq 0 (
    echo [CRITICAL] Rollback failed! Blue version unhealthy.
) else (
    echo [SUCCESS] Rollback to BLUE complete!
    start "" http://localhost:5000
)
pause