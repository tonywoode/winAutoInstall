@echo OFF & SETLOCAL
COLOR 17
MODE CON: COLS=50 LINES=8

:: as long as we're not mapping as admin, i think we can cd like below, then we can have relative path to the creds file
cd /D "%~dp0"
::for mapping NAS box. If we're at home, map it on local network. If we're not, map it over webdav
::using netdrive 2's command line tool. http://netdrive.net/ - I think this is going to be around for a while!!
::netdrive adds its cmd to %PATH% automatically


:: get netdrive vars
set config="..\netDriveCreds.cfg"
for /f "tokens=2* delims==" %%H in ('find "netDriveURL=" ^<%config% ') do (set URL=%%H)
for /f "tokens=2* delims==" %%I in ('find "netDriveUSER=" ^<%config% ') do (set USER=%%I)
for /f "tokens=2* delims==" %%J in ('find "netDrivePASS=" ^<%config% ') do (set PASS=%%J)
for /f "tokens=2* delims==" %%K in ('find "netDriveLETTER=" ^<%config% ') do (set LETTER=%%K)

Set NASDRIVELETTER=%LETTER:"=%:\
Set NETDRIVECMD="C:\Program Files\NetDrive2\nd2cmd"

:: this runs at startup, if you login too early, the local mapping doesn't work
:: let's try without this for a while, just to check its needed in all circumstances
::timeout 5 > NUL

::if we're local, act local. But note this check won't work unless you authenticate manually once and tick remember creds...
if exist N:\ ( net use N: /D )
net use N: \\Estuary\Emulators /user:%user% %PASS%
::else mount netdrive	
if %ERRORLEVEL% NEQ 0 (
  %NETDRIVECMD% -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
  subst N: %NASDRIVELETTER%Emulators
)

if exist Q:\ ( net use Q: /D )
net use Q: \\Estuary\Games /user:%user% %PASS%
::else mount netdrive	
if %ERRORLEVEL% NEQ 0 (
  if exist %NASDRIVELETTER% (
    echo.NAS Drive already Mapped via NetDrive
  ) else (
    %NETDRIVECMD% -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
  )
  subst Q: %NASDRIVELETTER%GAMES
)

::clear up
FOR %%Z IN (URL USER PASS LETTER) DO SET %%Z=
