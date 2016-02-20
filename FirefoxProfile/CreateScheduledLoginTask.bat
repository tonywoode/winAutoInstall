echo.This will create a scheduled task that runs when I login and backs up my Firefox profile to google drive
pause
<<<<<<< HEAD
..\Elevation\elevate schtasks /create /tn FirefoxProfileBackup /tr O:\Scripts\winAutoInstall\FirefoxProfile\refreshFirefoxProfileBackup.bat /sc onlogon /it /ru %USERNAME%
=======
..\Elevation\elevate schtasks /create /tn FirefoxProfileBackup /tr O:\winAutoInstall\FirefoxProfile\refreshFirefoxProfileBackup.bat /sc onlogon /it /ru %USERNAME%
>>>>>>> a5ab9cad0257d5939ba092dbdda12d8b542cf507
pause