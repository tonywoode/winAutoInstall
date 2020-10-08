@ECHO off & SETLOCAL
:: these actions are all idempotent - you won't get duplicate folders created if you run multiple times
::cd to this scripts dir
cd /D "%~dp0"

::import the reg file
REG IMPORT ./RegFile/WindowsRegSettings.reg

start /B DesktopFolderCreation\MakeMyDesktopFolders

:: restart explorer to hope to see the effects
TASKKILL /F /IM explorer.exe
TIMEOUT /T 3
START explorer.exe
exit
