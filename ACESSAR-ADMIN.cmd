@echo off
setlocal
cd /d "%~dp0"
where node.exe >nul 2>nul
if errorlevel 1 (
 echo Instale o Node.js 24 ou superior e abra este atalho novamente.
 pause
 exit /b 1
)
if not exist node_modules\vite\package.json (
 call npm.cmd install
 if errorlevel 1 (
  pause
  exit /b 1
 )
)
node --env-file-if-exists=.env scripts\local-access.mjs --admin
echo.
pause
