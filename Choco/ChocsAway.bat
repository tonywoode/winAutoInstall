@echo off & SETLOCAL

::cd to this scripts dir
cd /D "%~dp0"

color 17
::WE NEED AN EDITOR, AND WE NEED TO KNOW WHERE THE SCRIPTS ARE
SET NOTEPADPLUSPLUS="C:\Program Files (x86)\Notepad++\notepad++.exe"

ECHO.********************************************
ECHO.		CHOCOLATEY TOOL
ECHO.(COPY AND RUN THIS SCRIPT FROM YOUR DESKTOP)
ECHO.	MAKE CHANGES TO THE LOG FIRST
ECHO.	THEN WE'LL RUN AND UPDATE
ECHO.********************************************

IF EXIST %NOTEPADPLUSPLUS% (%NOTEPADPLUSPLUS% packages.config)

::CHOCO LIKES TO RUN AS ADMIN
.\..\Elevation\elevate installandUpdate