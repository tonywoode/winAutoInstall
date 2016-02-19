@ECHO off & SETLOCAL

::copy over dot files. Windows really doesn't like these
::so a trick is to echo them around
::sadly i didn't find a good trick for deleting

::cd to this scripts dir
cd /D "%~dp0"

set home="C:\%HOMEPATH%"
pushd %HOME%
IF EXIST ".gitconfig" (
		type ".gitconfig">".gitconfig_old"
		echo Please manually delete the existing .gitconfig I just backed up
		pause
	)

popd
echo Copying the .gitconfig that i had stored
type ".gitconfig">"%HOME%\.gitconfig" 

pause
