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
start /B /WAIT ..\Elevation\elevate powershell -noprofile -command "&{ start-process powershell -ArgumentList '-noprofile -file %DIR%MakeEmuDrivesScheduledTask.ps1' -verb RunAs}"

:: this won't work that's why we need the vbs: label P:Emulators
echo.Then give it a name
labelEmuDrives.vbs

echo.Next problem is that even with EnabledLinedConnections on, administrator STILL
echo.won't see your substed drives on some win10 machines, we need to actually have
echo.administrator map the same drives as %USER%, and the only way to do that is a
echo.scheduled task. see information here:
echo.http://superuser.com/questions/1026424/why-wont-my-mapped-drive-persist-for-elevated-user-after-reboot?rq=1
echo.and for further research see here:
echo.http://superuser.com/questions/29072/how-to-make-subst-mapping-persistent-across-reboots
echo.Note that elevated command prompt will default to System32 folder, you need full paths!
echo.Make a scheduled task that runs with the highest privileges on startup, effectively mapping as administrator
:: problem here is you won't get the 'on battery' functionality, this literaly won't run when on battery unless you untick it in shceduled task
::start /B /WAIT ..\Elevation\elevate schtasks /create /tn "Map Variable Drives" /tr "C:\Emulators\WinScripts\winAutoInstall\SetupVirtualDrives\mapDrives\mapVariableDrives.bat" /sc onlogon /it /ru SYSTEM /RL HIGHEST


pause
