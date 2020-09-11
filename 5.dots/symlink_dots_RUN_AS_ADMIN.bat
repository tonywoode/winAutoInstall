@ECHO off & SETLOCAL

::copy over dot files. Windows really doesn't like these
::one trick is to echo them around, sadly i didn't find a good trick for deleting
::another trick is two dots - windows ignores the one at the end and respects the one at the beginning
::but your source file can't have dots, hence gitignore not .gitignore
::I tried elevation with this script but no matter what you get "mklink can't be found", trust me!

::cd to this scripts dir
cd /D "%~dp0"

::this might or might not help...i've set it countless times but never confirmed it helping anything
fsutil behavior set SymlinkEvaluation R2L:1
fsutil behavior set SymlinkEvaluation R2R:1


set home="C:%HOMEPATH%"
pushd %HOME%
IF EXIST ".gitconfig" (
		type ".gitconfig">".gitconfig_old"
		echo Please manually delete the existing .gitconfig I just backed up
		pause
	)

popd

echo symlinking your git dots (not sure why the %CD% is needed but it sure is!)
echo dir is %CD%
mklink %HOME%\.gitconfig. "%CD%\gitconfig"
mklink %HOME%\gitignore_global.txt "%CD%\gitignore_global.txt"
pause
