@echo off
cd /d "%~dp0"
if not exist node_modules (
  call npm.cmd install
  if errorlevel 1 exit /b 1
)
node --env-file-if-exists=.env scripts\local-access.mjs --store
echo.
pause
