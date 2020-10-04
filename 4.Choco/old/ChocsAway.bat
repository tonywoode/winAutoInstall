@echo off & SETLOCAL

::cd to this scripts dir
cd /D "%~dp0"

color 17
::WE NEED AN EDITOR, AND WE NEED TO KNOW WHERE THE SCRIPTS ARE
SET NOTEPADPLUSPLUS="C:\Program Files\Notepad++\notepad++.exe"

ECHO.********************************************
ECHO.		CHOCOLATEY TOOL
ECHO.	QUERY FOR PACKAGES AND MAKE CHANGES FIRST
ECHO.	THEN AFTER WE'LL RUN AND UPDATE
ECHO.
ECHO. THERE ARE TWO ADMIN PROMPTS NOW: ONE FOR POWERSHELL
ECHO.  ANOTHER FOR RUNNING CHOCO. ONLY RUN THEE SECOND ONCE
ECHO.  YOU'VE QUIERED
ECHO.********************************************

:: We want an admin powershell window really (after problems with 'could not delete choco.exe.old'
:: And we want to close the cmd window we just opened (after, I kid you not, problems with the 'l' key
::  when this script is run via a symlink....
:: https://code.adonline.id.au/use-a-batch-file-to-run-your-powershell-scripts/
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass' -Verb RunAs}"



IF EXIST %NOTEPADPLUSPLUS% (START "" %NOTEPADPLUSPLUS% packages.config)


::CHOCO LIKES TO RUN AS ADMIN
.\..\Elevation\elevate installandUpdate
pause