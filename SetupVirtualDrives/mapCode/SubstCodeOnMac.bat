@echo off & setlocal
:: makes sure we have a drive O: that maps to code on osx
:: needs to be run every startup
:: problem is it lives on o: ;-)
:: so needs to be copied to all users startup (which you can find
:: with windows+R and then typing shell:common startup

:: remove any previous mappings (though there shouldn't be any as nothing here is perm)
net use O: /D
subst /D O:

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
::now do the similar for mapping NAS box. If we're at home, map it on local network. If we're not, map it over webdav
::using netdrive 2's command line tool. http://netdrive.net/ - I think this is going to be around for a while!!
::netdrive adds its cmd to %PATH% automatically
net use N: /D

::if we're local, act local
if exist "\\Estuary\Games" (net use N: \\Estuary\Games && EXIT /b)
	
::else mount netdrive		
set config="O:\Scripts\WinAutoInstall\SetupVirtualDrives\netDriveCreds.cfg"
for /f "tokens=2* delims==" %%H in ('find "netDriveURL=" ^<%config% ') do (set URL=%%H)
for /f "tokens=2* delims==" %%I in ('find "netDriveUSER=" ^<%config% ') do (set USER=%%I)
for /f "tokens=2* delims==" %%J in ('find "netDrivePASS=" ^<%config% ') do (set PASS=%%J)
for /f "tokens=2* delims==" %%K in ('find "netDriveLETTER=" ^<%config% ') do (set LETTER=%%K)
"C:\Program Files\NetDrive2\nd2cmd" -c m -t dav -u %URL% -a %USER% -p %PASS% -d %LETTER% -l nas 
subst N: "L:\GAMES"

::clear up
FOR %%Z IN (URL USER PASS LETTER) DO SET %%Z=
::exit
	