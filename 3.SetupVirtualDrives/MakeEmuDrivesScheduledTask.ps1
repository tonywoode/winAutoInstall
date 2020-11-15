$Sta = New-ScheduledTaskAction -Execute "C:\Emulators\WinScripts\winAutoInstall\3.SetupVirtualDrives\mapDrives\mapEmuDrives.bat"
$Stt = New-ScheduledTaskTrigger -AtLogon
$NTAuthoritySystemUser = "S-1-5-18"
$STPrin = New-ScheduledTaskPrincipal -UserId $NTAuthoritySystemUser -RunLevel "Highest"
$Stset = New-ScheduledTaskSettingsSet -MultipleInstances "IgnoreNew" -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries 
$TaskName = "MapEmuDrives"
Register-ScheduledTask $TaskName -Action $Sta  -Trigger $Stt  -Principal $STPrin -Settings $Stset
Start-ScheduledTask -TaskName $TaskName
#for troubleshooting Read-Host -Prompt "Press any key to continue"