@ECHO OFF & SETLOCAL

echo.Administrator can't see %USERNAME%s mapped drives. Let's fix that....
echo.Run me as administrator from the C drive and restart after please
echo.	see here for more info:
echo.		 http://superuser.com/questions/690287/command-prompt-in-administrator-mode-doesnt-see-mapped-drives
pause

set mykey="HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System"
set myvalue="EnableLinkedConnections"
reg query %mykey% /v %myvalue% 
echo %errorlevel%

if %errorlevel% equ 0 (
echo "%mykey%/%myvalue% exists- do nothing"
) else (
  echo "%mykey%/%myvalue% doesn't exist - add the value"
  pause
  reg add %mykey% /v EnableLinkedConnections /t REG_DWORD /d 00000001
  echo.Now administrator should see all of %USERNAME%s mapped drives
  echo.But beware the caveat here: http://www.winability.com/how-to-make-elevated-programs-recognize-network-drives/
  echo." if a standard user has created a mapped network drive pointing to a subfolder of a shared folder 
  echo.for example, drive Z: connected to //server/share/subfolder,
  echo.then the elevated user will see the drive Z:, but it will be pointing to the root share, //server/share/, not to the subfolder. "
  
)


echo.Next problem is that your HFS volume may have administrator restrictions 
echo.just a quirk with paragon's disk tools, need to fix that too
echo.see here:
echo.	http://kb_wp.paragon-software.com/article/268
echo. 	the manual option is to start web client service at boot
pause
set mykey="HKLM\SYSTEM\CurrentControlSet\Services\Hfsplus\Parameters"
set myvalue=""
reg query %mykey% > null 2>&1
if %errorlevel% equ 0 (
echo "%mykey% exists- do nothing" && pause && exit
) else (
  echo "%mykey% does not exist - add the key and value"
  pause
  reg add %mykey%
  reg add %mykey% /v "Fake FS Name" /t REG_SZ /d "CDFS"
)

echo.Now administrator should be able to run any exe on an hfs drive too. 
echo.NOW RESTART. 
pause