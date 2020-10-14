@ECHO off & SETLOCAL
:: these actions are all idempotent - you won't get duplicate folders created if you run multiple times

:: there's a number of different methods in this script of opening new windows without those processes closing the script. The best i got was a call, followed by an admin powershell, followed by
:: and admin cmd. At each stage the previous window gets closed, this works but I can't make it so that we can see the output of the powershell script before the window disappears

::cd to this scripts dir
cd /D "%~dp0"
SET DIR=%~dp0%

echo.makeing your usual desktop folders
call DesktopFolderCreation\MakeMyDesktopFolders

echo.now runing the powershell script that sets the windows defender exclusions
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoLogo -NoProfile -ExecutionPolicy Bypass -File ""%dIR%\WindowsDefenderExclusions\WindowsDefenderExclusions.ps1""' -Verb RunAs}"

::now importing the registry files, we need to be admin
..\Elevation\elevate cmd /c "%DIR%\RegFiles\ImportRegFiles_my_parent_runs_me_as_admin.cmd"