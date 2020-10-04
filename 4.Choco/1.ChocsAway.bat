@echo off & SETLOCAL

::https://code.adonline.id.au/use-a-batch-file-to-run-your-powershell-scripts/ (its the runas that does it)

::cd to this scripts dir
cd /D "%~dp0"
SET DIR=%~dp0%
COLOR 57
MODE CON: COLS=40 LINES=2
echo.Running Powershell As Administrator...
:: for NoLogo see https://superuser.com/q/645721/678231
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoLogo -NoProfile -ExecutionPolicy Bypass -File ""%dIR%\choco.ps1""' -Verb RunAs}"

