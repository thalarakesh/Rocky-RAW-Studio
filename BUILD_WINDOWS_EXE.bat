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
echo Installing build dependencies...
%PYTHON_CMD% -m pip install -r requirements-build.txt
if errorlevel 1 goto failed
%PYTHON_CMD% -m PyInstaller --noconfirm --clean --onefile --windowed --name Rocky_RAW_Studio --add-data "index.html;." --add-data "assets\logo.png;assets" --hidden-import=PIL.Image --hidden-import=PIL.ImageOps app.py
if errorlevel 1 goto failed
echo.
echo SUCCESS - Your EXE is at dist\Rocky_RAW_Studio.exe
pause
exit /b 0
:failed
echo.
echo Build failed. Check the error above, Python and internet connection.
pause
exit /b 1
