SET DIR=%~dp0%
..\Elevation\elevate cmd /c^
 "mklink "c:\Users\%username%\Desktop\ChocsAway" "%DIR%ChocsAway.bat" && echo.Choco Runner Linked to Desktop & pause"