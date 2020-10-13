@ECHO off & SETLOCAL
:: these actions are all idempotent - you won't get duplicate folders created if you run multiple times
::cd to this scripts dir
cd /D "%~dp0"
SET DIR=%~dp0%

::import the reg file
REG IMPORT ./RegFile/WindowsRegSettings.reg
:: make the desktop folders
start /B DesktopFolderCreation\MakeMyDesktopFolders
:: run the powershell script that sets the windows defender exclusions
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoLogo -NoProfile -ExecutionPolicy Bypass -File ""%dIR%\WindowsDefenderExclusions\WindowsDefenderExclusions.ps1""' -Verb RunAs}"

:: restart explorer to hope to see the effects of the first two actions (the Windows Defender stuff updates live (in the Security Centre UI too)
TASKKILL /F /IM explorer.exe
TIMEOUT /T 3
START explorer.exe
exit
