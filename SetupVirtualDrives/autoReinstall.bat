@echo off & SETLOCAL
::Change the DPI setting and log out so it can be activated

::cd to script directory, for administrator needs to run this
cd /D "%~dp0"

::copy the subst file into the startup dir if it doesn't exist
if (%b2eprogrampathname%)==() (set _SCRIPTDIR="%~dp0") else (set _SCRIPTDIR=%b2eprogrampathname%)
if exist "C:\Program Files\DAEMON Tools Lite\DTAgent.exe" set _DT="C:\Program Files\DAEMON Tools Lite\DTAgent.exe"
if exist "%_SCRIPTDIR%ForciblyWinmount.exe" start "" "%_SCRIPTDIR%ForciblyWinmount.exe"
if (%_DT%)==() set ERROR_MESSAGE="Please ensure the Daemon Tools command line executer ""DTAgent.exe"" is installed to its default location in Windows' Program Files Folder" && goto ERROR_POPUP

set _SCRIPTDIR="%~dp0"

