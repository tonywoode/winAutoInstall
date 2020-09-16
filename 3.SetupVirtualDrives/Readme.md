# Drive Mapping Scripts 2020

There are two main concerns herein: local and remote mappings. They are unrelated

## 1. Internal Mappings
Many years ago, I was prompted to use virtual drive mappings, 'subst' mappings in windows, for my Emulators drive. 
Later I gained utility from also subst mapping my Games drive. There are a few advantages. They really do help

The core idea used to be very simple in practise, subst P: C:\Emulators, but successive releases of Windows complicated
this simple idea to ludicrous extremes, the main pain points were persistence, administrator rights, admin vs user contexts and 
changing workarounds. In particular, there is the need for administrator to see the same mapped drives as user - else any attempt
to install programs as admin, or run code in both contexts for comparison, leads to frustration

Later I found the need to map my MAC's HFS+ HDD, with some conditionals based on whether we were in Parallels or Boot Camp. Since this had an admin
requirement, I conflated it witht eh Subst mappings. The need went away over time, as I migrated things away from cross os needs due essentially to it obviously
being inherently dangerous

Later, I needed to map network drives, my NAS drive, which I like to map nas SMB if I was local, and the joy of WebDAV if I wasn't
I wrongly conflated this with the subst mappings to produce a shared mapping script.

Here are some things that have, over the years, been used to maintain subst mappings, that either stopped working or never worked correctly, in broadly chronologicial order:

* EnableLinkedConnections registry key - from the early days of UAC, administrator used to be able to simply get Users mapped drives. Stopped working with an OS update.
* DOS Devices key hack - to make subst mappings persist 
    - variations on reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v P: /t REG_SZ /d "\??\C:\Emulators" /f. stopped working with an os update.
	- http://superuser.com/questions/29072/how-to-make-subst-mapping-persistent-across-reboots
	- https://superuser.com/questions/217561/why-is-a-subst-drive-usable-from-a-command-prompt-but-not-windows-7-explorer
	- https://answers.microsoft.com/en-us/windows/forum/windows_7-files/is-the-subst-command-broken-in-windows-7/4855524d-a28b-403e-8d7e-515926e01aaa
* All users startup folder script - ie: subst on every boot - never did make the administrator mappings
* Manual subst Mapping in both User and Admin contexts via Scheduled Task and Startup 
    - Make a scheduled task that runs with the highest privileges on startup, effectively mapping as administrator
    - complex to get right (see below) but mostly works. However, odd race conditions and very noisy
    - http://superuser.com/questions/1026424/why-wont-my-mapped-drive-persist-for-elevated-user-after-reboot?rq=1
	- start /B /WAIT ..\Elevation\elevate schtasks /create /tn "Map Variable Drives" /tr "C:\Emulators\WinScripts\winAutoInstall\SetupVirtualDrives\mapDrives\mapVariableDrives.bat" /sc onlogon /it /ru SYSTEM /RL HIGHEST

Other complications:
* Relabeling a drive won't work for subst drives if the parent drive (C:) has a name
* Relabeling a drive using the label command won't work for subst drives (requiring the vbs hack seen herein)
* Most routes to getting administrator in scripts use RunAs, which defaults cwd to System32 folder
* Creating a windows scheduled task programatically in CMD with schtasks will get you a task which will always fail if run on battery power
    - https://stackoverflow.com/questions/9075564/change-settings-for-power-for-windows-scheduled-task
* Scheduled Tasks are not tranferrable as exported (you need to delete the owner key)

The current functionality came from these finds
* Subst mappings just need to be remade now every startup - any workarounds appear to have been removed. I don't know why.
* I realised remote drives currently DON'T need to be mapped as Administrator - there were two concerns that made me think they did
    1. Symlink copying - for syncing drives, however symlinks caused so many issues I disabled syncing them entirely and moved to identifying and capturing them
	2. Running Emulator files directly from External locations - in which case mapping as admin would be required, but to date i've still not done this
  This realisation led to the split between local drives which need to be 'hard' substed invisibly and consistently at each boot, and remote drives which need to
  be visible, changeable and generally accessible in their mapping - remote drives become a simple startup-folder script.
* If you run a scheduled task as the user NTAuthority/SYSTEM, it maps drives for ALL users including administrator
    - you'll need to run this as administrative powershell though. Indeed you can't even import an xml stating runas this user to the scheduled tasks ui without launching THAT as administrator
    - however it fails to map the network drives, so its good I don't need them - possibly there's still the need for one-off password or 
	  other interative ui requirement that's preventing this)
	- another option powershell provides is to pass the xml generated by the scheduled tasks ui instead of programatically generating the task, which might be useful in future...
* If you use the powershell for auto scheduled-task creation, you have more precise control over the task than schtasks, including runnning when on battery power -
    see https://stackoverflow.com/questions/9075564/change-settings-for-power-for-windows-scheduled-task
	and the various elements' docs currently here: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=win10-ps
	
Note however that a scheduled task creation running as SYSTEM must be run as administrator, hence the task installer uses elevate to do so

## 2 . NAS Mappings
