# Remake Emulators Symlinks
Running this script should remake all symlinks that should exist in your Emulators Drive in order for Emulators to 
work correctly

The reason for the existence of the script is that Symlinks are very useful, however processes (in particular file
syncing processes) are always massively overcomplicated by the existence of symlinks, not helped at all by windows
requiring you to be administrator to manipulate symlinks:

I found myself trying to maintain a massive infrastructure of code and processes that tried to ensure that my syncing 
tools like FreeFileSync ran as admin (e.g.: making an admin runner and some way of ensuring that could be copied to 
the taskbar) in order to capture symlinks, and that syncing tools always copied symlinks directly and never followed 
them (but of course there was always some errant process or thoughtless action that copied the files the symlinks 
linked to, causing chaos). And to sync as admin we also always had to ensure that drives were mapped in an administrator 
context as well as user context. And this list of considerations ran on, until of course we get to the NAS box, which 
being a nix machine, won't ever be able to deal with windows symlinks, yet one day we might need it to.

Hence a massively easier option to deal with windows symlinks, and to automate them for future requirements, is to 
capture them at the point of filesync, and be able to replay them. That's what this script does. However its not 
automatic atm, just intended to be run whenever you change symlinks.

Another great use for this script is it simply captures what symlinks existed - so when the time comes that some new 
misbehaviour overwrites the symlinks with the target files again, we can reproduce the symlinks. 

# Origin and Intended Use
This is the output of another script that is currently kept here:
 P:\WinScripts\Emulator_PC_Switcher_Sync_Tool\RealtimeSync_with_FreeFileSync\Emulator_NAS_Sync
It lives with the NAS Sync Files so it can be (manually) run when symlinks change to recapture state. The source 
filepath is also printed as a comment in the top of the filepath.

The idea is that the production of this script is part of the syncing process, but the use of this script is not, 
its most often part of the initial drive setup, and its useful to capture existing symlinks in git as part of that 
process. So that's why this process crosses repos.

# Considerations
Symlinks won't be created unless the target path exists. There are some symlinks that point from Emulators (P:\) to
files kept in Games (F:\). If you run this script before the targets exist, the symlinks won't be created. This
isn't a problem for running the file again, the script is idempotent and you can run this as many times as you want,
at such time as all targets exist, running the script one last time will have reconstituted all the targets

Take note of comments in script regarding targets, which originally may have been relative etc. As pointed out there,
this shouldn't lose functionality at all by reconsituting to fullpath symlinks, but you lose flexibility to move files
and folders around e.g.: moving the location of my MAME folder. Any move requires remaking the symlinks and then remaking
this script

