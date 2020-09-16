SET DIR=%~dp0%
SET STARTUP=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\
SET DESKTOP=%USERPROFILE%\Desktop\
..\Elevation\elevate cmd /c^
 "mklink "%STARTUP%mapNASDrives.bat" "%DIR%mapDrives\mapNASDrives.bat" & mklink "%DESKTOP%mapNASDrives" "%DIR%mapDrives\mapNASDrives.bat" && echo.copied NAS mapper to Desktop & pause"