@echo off & setlocal
:: as long as we're not mapping as admin, i think we can cd like below, then we can have relative path to the creds file
cd /D "%~dp0"
::for mapping NAS box. If we're at home, map it on local network. If we're not, map it over webdav
::using netdrive 2's command line tool. http://netdrive.net/ - I think this is going to be around for a while!!
::netdrive adds its cmd to %PATH% automatically
if exist N:\ (
  net use N: /D
)

if exist Q:\ (
  net use Q: /D
)

:: get netdrive vars
set config="..\netDriveCreds.cfg"
for /f "tokens=2* delims==" %%H in ('find "netDriveURL=" ^<%config% ') do (set URL=%%H)
for /f "tokens=2* delims==" %%I in ('find "netDriveUSER=" ^<%config% ') do (set USER=%%I)
for /f "tokens=2* delims==" %%J in ('find "netDrivePASS=" ^<%config% ') do (set PASS=%%J)
for /f "tokens=2* delims==" %%K in ('find "netDriveLETTER=" ^<%config% ') do (set LETTER=%%K)

:: this runs at startup, if you login too early, the local mapping doesn't work
timeout 5 > NUL

::if we're local, act local. But note this check won't work unless you authenticate manually once and tick remember creds...
net use N: \\Estuary\Emulators /user:%user% %PASS%
::else mount netdrive	
if %errorlevel% NEQ 0 (
  "C:\Program Files\NetDrive2\nd2cmd" -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
  subst N: L:\Emulators
)

::if we're local, act local. But note this check won't work unless you authenticate manually once and tick remember creds...
net use Q: \\Estuary\Games /user:%user% %PASS%
::else mount netdrive	
if %errorlevel% NEQ 0 (
  "C:\Program Files\NetDrive2\nd2cmd" -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
  subst Q: L:\GAMES
)

::clear up
FOR %%Z IN (URL USER PASS LETTER) DO SET %%Z=
::exit
	
