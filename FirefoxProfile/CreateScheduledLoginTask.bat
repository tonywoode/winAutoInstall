echo.This will create a scheduled task that runs when I login and backs up my Firefox profile to google drive
pause
..\Elevation\elevate schtasks /create /tn FirefoxProfileBackup /tr O:\Scripts\winAutoInstall\FirefoxProfile\hiddenrunner.bat /sc onlogon /it /ru %USERNAME%
pause