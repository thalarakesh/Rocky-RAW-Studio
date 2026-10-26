@echo off
setlocal
cd /d "%~dp0"
set "PYTHON_CMD="
where py >nul 2>nul
if not errorlevel 1 (
  py -3 -c "import sys; assert sys.version_info >= (3,10)" >nul 2>nul
  if not errorlevel 1 set "PYTHON_CMD=py -3"
)
if not defined PYTHON_CMD (
  where python >nul 2>nul
  if not errorlevel 1 (
    python -c "import sys; assert sys.version_info >= (3,10)" >nul 2>nul
    if not errorlevel 1 set "PYTHON_CMD=python"
  )
)
if not defined PYTHON_CMD (
 echo.
 echo [ERROR] Python 3.10 or newer was not detected.
 echo.
 echo Install Python from https://www.python.org/downloads/windows/
 echo During installation tick "Add python.exe to PATH".
 echo Then close and reopen Command Prompt and try again.
 echo.
 pause
 exit /b 1
)
echo Using %PYTHON_CMD%
%PYTHON_CMD% app.py
if errorlevel 1 (
 echo.
 echo Software could not start. See the error above.
 pause
)
