SET DIR=%~dp0%
SET STARTUP=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\
..\Elevation\elevate cmd /c^
 "mklink "%STARTUP%mapNASDrives.bat" "%DIR%mapDrives\mapNASDrives.bat" && echo.copied NAS mapper to all users startup: start+r then 'shell:common startup' to get there & pause"