# This file generated from P:\WinScripts\Emulator_PC_Switcher_Sync_Tool\RealtimeSync_with_FreeFileSync\Emulator_NAS_Sync\5.create_symlinks_replace_script.ps1
param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}
'running with full privileges'
pushd "P:\ARCADE\CPS3\cps3"
New-Item -ItemType SymbolicLink -Path "P:\ARCADE\CPS3\cps3\CHD" -Target "F:\Arcade\CPS3\CHD"
popd
pushd "P:\Mame\mame"
New-Item -ItemType SymbolicLink -Path "P:\Mame\mame\mess.ini" -Target "mame.ini"
popd
pushd "P:\Mame\mame\ini"
New-Item -ItemType SymbolicLink -Path "P:\Mame\mame\ini\mame.ini" -Target "..\mame.ini"
popd
pushd "P:\Mame\mame\ini"
New-Item -ItemType SymbolicLink -Path "P:\Mame\mame\ini\ui.ini" -Target "..\ui.ini"
popd
pushd "P:\PC\BoR\OpenBOR"
New-Item -ItemType SymbolicLink -Path "P:\PC\BoR\OpenBOR\paks" -Target "F:\BoR\OpenBoR\Paks"
popd
pushd "P:\Retroarch\RetroArch\saves\mame"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\saves\mame\cfg" -Target "..\..\..\..\Mame\mame\cfg"
popd
pushd "P:\Retroarch\RetroArch\system\mame"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\hash" -Target "..\..\..\..\Mame\mame\hash"
popd
pushd "P:\Retroarch\RetroArch\system\mame"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\ini" -Target "..\..\..\..\Mame\mame\ini"
popd
pushd "P:\Retroarch\RetroArch\system\mame"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\mame.ini" -Target "P:\mame\mame\mame.ini"
popd
pushd "P:\Retroarch\RetroArch\system\mame"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\ui.ini" -Target "P:\mame\mame\ui.ini"
popd
pushd "P:\Retroarch\RetroArch\system\mame\ini"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\ini\mame.ini" -Target "..\mame.ini"
popd
pushd "P:\Retroarch\RetroArch\system\mame\ini"
New-Item -ItemType SymbolicLink -Path "P:\Retroarch\RetroArch\system\mame\ini\ui.ini" -Target "..\ui.ini"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\bios41A.bin" -Target "..\..\BIOS\bios41A.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\DTLH-3000.bin" -Target "..\..\BIOS\DTLH-3000.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\DTLH-3002.bin" -Target "..\..\BIOS\DTLH-3002.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-1000.bin" -Target "..\..\BIOS\SCPH-1000.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-1001.bin" -Target "..\..\BIOS\SCPH-1001.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-5000.bin" -Target "..\..\BIOS\SCPH-5000.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-5500.bin" -Target "..\..\BIOS\SCPH-5500.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-5502.bin" -Target "..\..\BIOS\SCPH-5502.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-7000.bin" -Target "..\..\BIOS\SCPH-7000.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-7001.bin" -Target "..\..\BIOS\SCPH-7001.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-7003.bin" -Target "..\..\BIOS\SCPH-7003.bin"
popd
pushd "P:\SONY\PS1\EPSXE\bios"
New-Item -ItemType SymbolicLink -Path "P:\SONY\PS1\EPSXE\bios\SCPH-7502.bin" -Target "..\..\BIOS\SCPH-7502.bin"
popd
