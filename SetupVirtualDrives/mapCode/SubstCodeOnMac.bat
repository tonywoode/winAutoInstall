@echo off & setlocal
:: makes sure we have a drive O: that maps to code on osx
:: needs to be run every startup
:: problem is it lives on o: ;-)
:: so needs to be copied to all users startup (which you can find
:: with windows+R and then typing shell:common startup

::TODO: in the run-once virtual drive setup script that goes with this script, you'll see registry editing code that attempts to make this subst
:: permanent, sadly after I subst P: /D one day on windows 1803, that reg key just doesn't seem to work anymore, we lose P: every boot
:: I think the proper solution may be the current user reg key changes cited here: https://superuser.com/questions/29072/how-to-make-subst-mapping-persistent-across-reboots
:: but for now let's just mount on every boot, like we do with the other drives here
subst P: C:\Emulators

:: remove any previous mappings (though there shouldn't be any as nothing here is perm)
if exist O:\ ( 
  net use O: /D
)

::three cases are 1)river 2)native boot on pond and 3) parallels boot on pond
:: The last case is interesting, we CAN actually subst a network drive we map 
::  like (subst O: Z:\Users\twoode\CODE), but then opening any executables on the 
::  resulting drive kicks off windows smartscreen every time. So just make
::  the Mac drive available on the parallels 'network' and we net use it instead.

if exist E:\CODE (subst O: E:\CODE) else (
	if exist E:\Users\twoode\CODE (subst O: E:\Users\twoode\CODE) else (
		if exist "\\Mac\Macintosh HD\Users\twoode\CODE" (net use O: "\\Mac\Macintosh HD\Users\twoode\CODE") || echo "can't map the network code drive"
	)	
)

::Map games drive in the same way. Outer loop is for river
if not exist F:\GAMES_DRIVE (
  if exist R:\GAMES_DRIVE ( subst F: R:\) else (
  	if exist S:\GAMES_DRIVE (subst F: S:\)
  ) || echo "can't find games drive"
)|| echo "games drive appears to be natively mapped"

::now do the similar for mapping NAS box. If we're at home, map it on local network. If we're not, map it over webdav
::using netdrive 2's command line tool. http://netdrive.net/ - I think this is going to be around for a while!!
::netdrive adds its cmd to %PATH% automatically
if exist Q:\ (
  net use Q: /D
)

:: get netdrive vars
set config="P:\WinScripts\WinAutoInstall\SetupVirtualDrives\netDriveCreds.cfg"
for /f "tokens=2* delims==" %%H in ('find "netDriveURL=" ^<%config% ') do (set URL=%%H)
for /f "tokens=2* delims==" %%I in ('find "netDriveUSER=" ^<%config% ') do (set USER=%%I)
for /f "tokens=2* delims==" %%J in ('find "netDrivePASS=" ^<%config% ') do (set PASS=%%J)
for /f "tokens=2* delims==" %%K in ('find "netDriveLETTER=" ^<%config% ') do (set LETTER=%%K)

:: this runs at startup, if you login too early, the local mapping doesn't work
timeout 5 > NUL

::if we're local, act local. But note this check won't work unless you authenticate manually once and tick remember creds...
net use Q: \\Estuary\Games /user:%user% %PASS%
::else mount netdrive	
if %errorlevel% NEQ 0 (
  "C:\Program Files\NetDrive2\nd2cmd" -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
  subst Q: L:\GAMES
)

:: temporary step, mount N: drive as C:\qpGame as we now have tens of thousands of symlinks pointing at N:
::   and we want them to actually respawn in this tempdrive, IOC at its finest!
:: TODO: you're assuming C:\QPGame exists, and does this need only mapping on POND or on all pcs, and is this even needed any more at all?
subst N: C:\QPGame

::clear up
FOR %%Z IN (URL USER PASS LETTER) DO SET %%Z=
::exit
	
