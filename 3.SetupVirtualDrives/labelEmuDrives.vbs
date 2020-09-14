'* CMD's label command does not work on virtual drives, whether you are admin or not
'* this does if called from command prompt. 
'* See https://social.technet.microsoft.com/Forums/windows/en-US/5cbc9ef4-b58a-4ba8-9b9d-84bfe1084827/change-label-of-subst-virtual-drive?forum=itproxpsp
Set oShell = WScript.CreateObject("Shell.Application")
oShell.NameSpace("P:\").Self.Name = "Emulators"
oShell.NameSpace("F:\").Self.Name = "Games"