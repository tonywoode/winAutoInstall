@ECHO off & SETLOCAL


::cd to this scripts dir
cd /D "%~dp0"

echo.Make sure you've run drive mapper script first, or maybe administrator won't be able to see the gamebase exe as its on a virtual drive

echo.First, we install Gamebase - tell it to install to P:\Gamebase (make sure it doesn't install to P:\Gamebase\gamebase)
pause
set GAMEBASE_DIR="P:\GAMEBASE"
%GAMEBASE_DIR%\gamebase-setup-v1.3-full


echo.Next, let's export the registry for gamebase, I think that lives at %GAMEBASE_DIR%
pause

REG IMPORT %GAMEBASE_DIR%\Gamebase.reg

set WINUAE_DIR="P:\Commodore\Amiga\WinUAE"
echo.Now, WinUAE has some registry entries to add, I think that lives at %WINUAE_DIR%
pause
REG IMPORT %WINUAE_DIR%\WinUAEReg.reg

set MEDNAFEN_HOME="C:\Emulators\Mednafen"
echo.Now set MEDNAFEN_HOME to be %MEDNAFEN_HOME%\Mednafen
echo.we do this in case you need to ever set another HOME
echo.***TYPE EXIT AFTER THIS IS DONE***
pause
start /B /WAIT .\..\Elevation\elevate setx MEDNAFEN_HOME %MEDNAFEN_HOME%\Mednafen /m
echo.and the gtk2 runtime is needed for mednaffe gui
pause
%MEDNAFEN_HOME%\MednaffeNeedsGTKRuntimeInstaller\gtk2-runtime-2.24.10-2012-10-10-ash.exe

set EPSXE_DIR="P:\SONY\PS1"
echo.Next we'll add epsxe's registry entries from %EPSXE_DIR%
echo.Remember that's for the keyboard controls, not resolution
pause
REG IMPORT %EPSXE_DIR%\EPSXE_KEYBOARDDUALSHOCK.reg

set GAMECUBE_DIR="P:\Nintendo\Gamecube Wii"
echo.Next we'll specify local-user directories to gamecube entries from %GAMECUBE_DIR%
echo.Remember we also put a file called LOCAL.txt in the gamecube dir, both have the same effect
pause
REG IMPORT %GAMECUBE_DIR%\LocalUserDirs.reg


echo.All done...
pause