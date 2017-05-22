@echo off & SETLOCAL

:: Installs chocolatey packages from a list, then updates all your installs, then reports back

::cd to this scripts dir
cd /D "%~dp0"
::install from the xml
cinst -y packages.config
echo.
echo.Now let's check for updates....
echo.
pause
cup all -y

echo.
echo.Lastly, just to help out, I'll open that log
echo.
pause
NOTEPAD C:\ProgramData\chocolatey\logs\chocolatey.log
exit

::unfortunately chocolatey doesn't let you use the packages.config for updates
::hence having to update "all"
::a method to update packages as it goes down a txt list of strings is below
::but it would be a shame to have to go there
::n.b.: the eol=# ensures we can put comments in a text file
::
::for /f "eol=# tokens=* delims=" %%g in (MyPrograms.txt) do (
::	cinst -y %%g
::	cup -y %%g
::)
