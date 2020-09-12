::note sure the cd below is worthwhile, administrators dp0 is somewhere odd, is there another/more attractive option than full paths anyway?
cd /D "%~dp0"
( mklink "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mapNASDrives.bat" "P:\WinScripts\winAutoInstall\3.SetupVirtualDrives\mapDrives\mapNASDrives.bat" )
pause