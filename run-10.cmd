@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

set "PYTHON=%CD%\.venv\Scripts\python.exe"
set "ATTEMPTS=3"
set "SUCCESS=0"
set "FAILED=0"

if not exist "%PYTHON%" (
    echo [ERROR] Python not found: %PYTHON%
    echo Run the project setup first.
    exit /b 1
)

for /L %%I in (1,1,10) do (
    echo.
    echo ==================================================
    echo Run %%I/10
    echo ==================================================
    "%PYTHON%" -m nodes --count 1 --threads 1 --attempts %ATTEMPTS% --hide-browser
    if errorlevel 1 (
        set /a FAILED+=1
        echo [WARN] Run %%I failed
    ) else (
        set /a SUCCESS+=1
    )
)

echo.
echo ==================================================
echo Completed: !SUCCESS!/10 success, !FAILED!/10 failed
echo ==================================================
if not "!SUCCESS!"=="10" exit /b 1
exit /b 0