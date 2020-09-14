@echo off & setlocal
:: maybe this needs to be copied to all users startup (which you can find with windows+R and then typing shell:common startup

::TODO: in the run-once virtual drive setup script that goes with this script, you'll see registry editing code that attempts to make this subst
:: permanent, sadly after I subst P: /D one day on windows 1803, that reg key just doesn't seem to work anymore, we lose P: every boot
:: I think the proper solution may be the current user reg key changes cited here: https://superuser.com/questions/29072/how-to-make-subst-mapping-persistent-across-reboots
:: but for now let's just mount on every boot, like we do with the other drives here
:: TODO: now this doesn't seem needed anymore on 1809/1903 - ie: remove this line and reboot and P: is still mapped in RIVER, that doutbless means that some unanticipated
::  factor is at work
subst P: C:\Emulators

if "%computername%"=="TYPHOON-WIN"    (subst F: C:/Games)

::Map games drive in the same way. Outer loop is for river
if not exist F:\GAMES_DRIVE (
  if exist R:\GAMES_DRIVE ( subst F: R:\) else (
  	if exist S:\GAMES_DRIVE (subst F: S:\)
  ) || echo "can't find games drive"
)|| echo "games drive appears to be natively mapped"

