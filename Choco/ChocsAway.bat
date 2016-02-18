@echo off & SETLOCAL

::cd to this scripts dir
cd /D "%~dp0"

color 17
::WE NEED AN EDITOR, AND WE NEED TO KNOW WHERE THE SCRIPTS ARE
SET NOTEPADPLUSPLUS="C:\Program Files (x86)\Notepad++\notepad++.exe"

ECHO.********************************************
ECHO.		CHOCOLATEY TOOL
ECHO.	QUERY FOR PACKAGES AND MAKE CHANGES FIRST
ECHO.	THEN AFTER WE'LL RUN AND UPDATE
ECHO.********************************************

::we ALWAYS want to query choco first, so give us a command prompt so we can
Start /B CMD /K

IF EXIST %NOTEPADPLUSPLUS% (%NOTEPADPLUSPLUS% packages.config)

::CHOCO LIKES TO RUN AS ADMIN
.\..\Elevation\elevate installandUpdate