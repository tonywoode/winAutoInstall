@ECHO off & SETLOCAL


::cd to this scripts dir
cd /D "%~dp0"

echo.Make sure you've run drive mapper script first, or maybe administrator won't be able to see the gamebase exe as its on a virtual drive

echo.First, we install Gamebase - tell it to install to P:\Gamebase (make sure it doesn't install to P:\Gamebase\gamebase)
dir
pause
gamebase-setup-v1.3-full

set GAMEBASE_DIR="P:\Emulator_PC_Switcher_Sync_Tool\Gamebase_Import_Export"
echo.Next, let's export the registry for gamebase, I think that lives at %GAMEBASE_DIR%
pause

REG IMPORT %GAMEBASE_DIR%\Gamebase.reg

set WINUAE_DIR="."
echo.Now, WinUAE has some registry entries to add, I think that lives at %WINUAE_DIR%
pause
REG IMPORT %WINUAE_DIR%\WinUAEReg.reg

set MEDNAFEN_HOME="C:\Emulators\Mednafen\Mednafen"
echo.Now set MEDNAFEN_HOME to be %MEDNAFEN_HOME%
echo.***TYPE EXIT AFTER THIS IS DONE***
pause
.\..\Elevation\elevate setx MEDNAFEN_HOME "C:\Emulators\Mednafen\Mednafen" /m

echo.All done...
pause