@ECHO off & SETLOCAL
:: these actions are all idempotent - you won't get duplicate folders created if you run multiple times
::cd to this scripts dir
cd /D "%~dp0"
SET DIR=%~dp0%

echo. now importing your standard registry files for windows settings changes, we need to be admin I hope we are

REG IMPORT "%DIR%/WindowsRegSettings.reg"
REG IMPORT "%DIR%/Add_Shift+Open_command_window_here.reg"
REG IMPORT "%DIR%/Add_Shift+Open_command_window_here_as_administrator.reg"
REG IMPORT "%DIR%/Add_Shift+Open_PowerShell_window_here_as_administrator_context_menu.reg"

:: restart explorer to hope to see the effects of the first two actions (the Windows Defender stuff updates live (in the Security Centre UI too)
TASKKILL /F /IM explorer.exe
TIMEOUT /T 5
START explorer.exe
exit

