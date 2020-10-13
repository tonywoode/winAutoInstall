# https://www.tenforums.com/tutorials/5924-add-remove-microsoft-defender-antivirus-exclusions-windows-10-a.html
# needs to be run as administrator as alters the registry at Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\
# the great advantage of doing this from a powershell script over the UI is that we can add locations which do not currently exist,
# this allows us to make a generic script


# First we do folder exclusions, these just need to be a root folder and all underneath is excluded
$folderExclusions = @(
  #First Games and Emulators locally
  "C:\Games",
  "C:\Emulators",
  #Then those substed as drives (I just don't know if you additionally need to do this, err on side of caution) 
  "F:\",
  "P:\",
  #Then the same as Mapped from the NAS by our drive mapper
  "N:\",
  "Q:\",
  #Then Each machine that could be accessed (which will include ourself, which may actually be necessary/useful)
  "\\Estuary\Games", 
  "\\Estuary\Emulators", 
  "\\RIVER\Games", 
  "\\RIVER\Emulators", 
  "\\Lagoon\Games", 
  "\\Lagoon\Emulators",
  "\\POND\Games",
  "\\POND\Emulators",
  "\\typhoon-win\Games",
  "\\typhoon-win\Emulators"
)

Write-Output "Adding File Exclusions, see the results in the Defender UI or here: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths"

$folderExclusions.ForEach({ 
  Write-Output "Adding $_ to Windows Defender File Exclusions"
  Add-MpPreference -ExclusionPath "$_" -Force
})

# Then we do process exclusions, for years I was excluding individual processes badly, until I read the docs and
# and saw wildcarding on source location was a thing, they become somewhat like folder exclusions then
# see https://support.microsoft.com/en-us/help/4577461/how-to-add-a-file-type-or-process-exclusion-to-windows-security
# but the big difference to folder exclusions is that the paths where we expect to be running executables are minimal
# compared to the the path's we expect to be running files

Write-Output "Adding Process Exclusions, see the results in the Defender UI or here: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes"

$processExclusions = @(
 # Any Emulators exe
 "C:\Emulators\*",
 # The same location substed because it may be necessary
 "P:\*",
 # Then we have to remember that PC Games ARE executables, they don't get run with Emulators. I can't do much about natively installed games
 # but I CAN do this
 "C:\Games\PC Games\*",
 # And the Substed version of that
 "F:\PC Games\*"
)

$processExclusions.ForEach({ 
  Write-Output "Adding $_ to Windows Defender Process Exclusions"
  Add-MpPreference -ExclusionProcess "$_" -Force
})