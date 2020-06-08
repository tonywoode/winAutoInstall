@echo off & SETLOCAL

::cd to this scripts dir
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

subst P: C:\Emulators
subst O: E:\CODE

:: this won't work that's why we need the vbs: 
:: label P:Emulators

echo.Then give it a name (we can only give CODE its name if we lose the name Macdrive for E:, we don't want that)
labelEmulators.vbs

::lastly make it stick by linking it in all users startup
::(TODO: you should launch as admin and runas user, not vice versa....)
echo.
echo.AND NOW PLEASE JUST KEEP TYPING EXIT 
echo.
start /B /WAIT .\..\Elevation\elevate reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v P: /t REG_SZ /d "\??\C:\Emulators" /f
:: we have three use cases for drive O: river, pond natively, and pond on mac. We need to unsubst and subst on most every boot, so doing it as admin permanently on each time is a real pain on pond, we'll just run a bat, so the last line commented out
if "%computername%"=="RIVER" (start /B /WAIT .\..\Elevation\elevate reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v O: /t REG_SZ /d "\??\E:\CODE" /f)
::if "%computername%"=="POND" (start /B /WAIT .\..\Elevation\elevate reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v O: /t REG_SZ /d "\??\E:\Users\twoode\CODE" /f)


echo.Next problem is that even with EnabledLinedConnections on, administrator STILL
echo.won't see your substed drives on some win10 machines, we need to actually have
echo.administrator map the same drives as %USER%, and the only way to do that is a
echo.scheduled task. see information here:
echo.http://superuser.com/questions/1026424/why-wont-my-mapped-drive-persist-for-elevated-user-after-reboot?rq=1
echo.and for further research see here:
echo.http://superuser.com/questions/29072/how-to-make-subst-mapping-persistent-across-reboots
echo.I think the following command should work.
echo.First copy the mapper to common startup (see notes in that bat) effectively mapping as %USER%
echo.Note that administrators command prompt will default to System32 folder, you need full paths!
start /B /WAIT ..\Elevation\elevate cmd /k copy P:\WinScripts\winAutoInstall\SetupVirtualDrives\mapDrives\mapVariableDrives.bat "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mapVariableDrives.bat"
echo.Then make a scheduled task that runs with the highest privileges on startup, effectively mapping as administrator
start /B /WAIT ..\Elevation\elevate schtasks /create /tn "Map Variable Drives" /tr "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mapVariableDrives.bat" /sc onlogon /it /ru %USERNAME% /RL HIGHEST

pause
