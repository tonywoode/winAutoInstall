@echo off & SETLOCAL

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
start /B /WAIT Elevation\elevate label C:

echo.Next make the virtual drives

subst P: C:/Emulators
:: subst O: (wherever code is....)

:: this won't work that's why we need the vbs: label P:Emulators

echo.Then give it a name
labelEmulators.vbs

::lastly make it stick by linking it in all users startup
Elevation\elevate reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v P: /t REG_SZ /d "\??\C:\Emulators" /f
::if "%computername%"=="RIVER" (reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v O: /t REG_SZ /d "\??\E:\CODE" /f)
::if "%computername%"=="POND" (reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v O: /t REG_SZ /d "\??\C:\Users\Tony\CODE" /f)

pause
