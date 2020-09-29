@ECHO off & SETLOCAL

::cd to this scripts dir
cd /D "%~dp0"

::import the reg file
REG IMPORT ./RegFile/WindowsRegSettings.reg

:: restart explorer to hope to see the effects
TASKKILL /F /IM explorer.exe
TIMEOUT /T 3
START explorer.exe
