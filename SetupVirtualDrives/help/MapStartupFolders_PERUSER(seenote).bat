
::cd to script directory, in case administrator needs to run this
cd /d "%~dp0" 

subst.exe P: C:\Emulators

if "%computername%"=="RIVER" (call subst.exe O: E:\CODE)
if "%computername%"=="LAGOON" (call subst.exe O: C:\Users\Tony\CODE)

