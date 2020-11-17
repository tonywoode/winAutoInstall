@ECHO off & SETLOCAL

::copy over dot files. Windows really doesn't like these
::one trick is to echo them around, which I do to copy them
::another trick is two dots - windows ignores the one at the end and respects the one at the beginning
::note the source files can be dotted, this didn't seem to work on one machine but did on another...
::I tried elevation with this script but no matter what you get "mklink can't be found", trust me!

::cd to this scripts dir
cd /D "%~dp0"

::this might or might not help...i've set it countless times but never confirmed it helping anything
fsutil behavior set SymlinkEvaluation R2L:1
fsutil behavior set SymlinkEvaluation R2R:1


set home=C:%HOMEPATH%
pushd %HOME%

SET dot1=.gitconfig
SET dot2=.gitignore

IF EXIST %dot1% (
  call :BACKUP_AND_DELETE_EXISTING %dot1%
)

IF EXIST %dot2% (
  call :BACKUP_AND_DELETE_EXISTING %dot2%
)
	
popd

echo symlinking your git dots (not sure why the %CD% is needed but it sure is!)
echo dir is %CD%
:: note the dot here in destination!!!!
mklink %HOME%\%dot1%. "%CD%\%dot1%"
mklink %HOME%\%dot2%. "%CD%\%dot2%"

::we have a problem now, .gitconfig internally reference .gitignore, most sensible would be to reference the symlink to it in %HOME%,
::  the one we just made, but you can't put system variables in .gitconfig, and windows changed its behaviour recently, forcing a different
::  user folder name than most people previously would have used. So home folder name varies. So now, internally, .gitconfig states the
::  global gitignore is in this script's directory, rather than in my user folder. Problem solved, but bear in mind that .gitignore's symlink
::  in %HOMEPATH% is now just for ease of access for you
echo remember global .gitignore is stated as in this scripts dir 
echo FINISHED
pause
exit /b



:BACKUP_AND_DELETE_EXISTING
set file=%1
type %file%>%file%_old
del %file%	
echo renamed the existing %file% to %file%_old

