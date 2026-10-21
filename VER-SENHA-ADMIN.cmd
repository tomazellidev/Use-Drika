@echo off
setlocal
cd /d "%~dp0"
where node.exe >nul 2>nul
if errorlevel 1 (
 echo Instale o Node.js 24 ou superior para consultar a senha por este atalho.
 pause
 exit /b 1
)
node --env-file-if-exists=.env scripts\local-access.mjs --password
echo.
pause
