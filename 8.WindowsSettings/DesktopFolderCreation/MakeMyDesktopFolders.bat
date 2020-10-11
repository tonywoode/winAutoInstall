@echo off

:: get the icons i usually use for these folders
:: https://www.raymond.cc/blog/how-to-change-the-standard-folder-icon-to-another-icon/

set RETRODIR="C:\Users\%username%\Desktop\Retro"
mkdir %RETRODIR%
ECHO [.ShellClassInfo] >%RETRODIR%\desktop.in
ECHO IconResource=C:\Windows\system32\SHELL32.dll,27 >>%RETRODIR%\desktop.in
move %RETRODIR%\desktop.in %RETRODIR%\desktop.ini
attrib +S +H %RETRODIR%\desktop.ini
attrib +R %RETRODIR%

set APPDIR="C:\Users\%username%\Desktop\Apps"
mkdir %APPDIR%
ECHO [.ShellClassInfo] >%APPDIR%\desktop.in
ECHO IconResource=C:\Windows\system32\SHELL32.dll,121 >>%APPDIR%\desktop.in
move %APPDIR%\desktop.in %APPDIR%\desktop.ini
attrib +S +H %APPDIR%\desktop.ini
attrib +R %APPDIR%

:: now a shortcut to qps dir, a symlink will make your paths think we're on the desktoop (which may or may not be fine)
:: so do a real shortcut https://superuser.com/a/836818
set TARGET='P:\QUICKPLAY\QuickPlayFrontend\qp\'
set SHORTCUT='%USERPROFILE%\Desktop\qp.lnk'
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile
%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut(%SHORTCUT%); $S.TargetPath = %TARGET%; $S.Save()"

