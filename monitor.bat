@echo off
setlocal

:: ===== Configuration =====
set URL=http://localhost:5000/health
set LOGFILE=monitor_log.txt

:: ===== Timestamp Generation =====
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
    set DATE=%%c-%%a-%%b
)
for /f "tokens=1-2 delims=: " %%a in ("%time%") do (
    set TIME=%%a:%%b
)
set TIMESTAMP=%DATE% %TIME%

:: ===== Health Check =====
curl -s %URL% >nul
if errorlevel 1 (
    echo [%TIMESTAMP%] ❌ App is DOWN >> %LOGFILE%
) else (
    echo [%TIMESTAMP%] ✅ App is UP >> %LOGFILE%
)

endlocal
