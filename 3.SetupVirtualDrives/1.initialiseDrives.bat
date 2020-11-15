@echo off & SETLOCAL

::cd to this scripts dir
SET DIR=%~dp0%
cd /D "%~dp0"

echo.First take the C: drives label away - switching to admin cmd
::We won't be able to relabel any drive subst from C: until C: has no drive label
echo.VERY MANUAL STEPS NEEDED
echo.PLEASE JUST HIT ENTER, THEN Y
echo.THEN TYPE EXIT
echo.(and don't complain about it!)
echo.
echo.	(need new subshell to get admin
echo.	need admin to get blank C drive
echo. 	need blank C drive to rename virtual drives)
echo.

:: uses Elevation the command-line administrative elevator from https://technet.microsoft.com/en-us/magazine/2007.06.utilityspotlight.aspx?
start /B /WAIT .\..\Elevation\elevate label C:

echo.Next make the virtual drives
:: we don't need both elevate and the runas - see choco script, just use powershell
powershell.exe -noprofile -command "&{ start-process powershell.exe -ArgumentList '-noprofile -file %DIR%MakeEmuDrivesScheduledTask.ps1' -verb RunAs}"

:: this won't work that's why we need the vbs: label P:Emulators
echo.Then give it a name
start /B /WAIT .\..\Elevation\elevate cscript labelEmuDrives.vbs

echo.Done
pause
