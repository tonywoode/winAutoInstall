echo off
set _SCRIPTDIR=%~dp0
set log_dir=%_SCRIPTDIR%log
set homedir="C:/%HOMEPATH%"
robocopy "%HOMEDIR%/FirefoxProfile" "%HOMEDIR%\Google Drive\DRIVERS_CONFIGS_MANUALS\FirefoxProfile\FirefoxProfile%COMPUTERNAME%" /mir /R:5 /W:5 /SL /TEE /ETA /LOG:%log_dir%\copyFirefoxProfile%COMPUTERNAME%.log


