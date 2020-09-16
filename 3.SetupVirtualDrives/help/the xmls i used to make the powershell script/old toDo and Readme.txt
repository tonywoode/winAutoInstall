I've put the scheduled task XML in here too, though the parent folders bat's don't use it. Delete this when its clear that the scheduled task creation code in the parent folder's bat works in all circumstances to map code under the administrative command prompt

What this is saying is: look at initialiseDrives.bat and you'll see an automated action to copy the script here to all-users startup and make a scheduled task to run it there, but the issue there is its a one-off that will refresh the script only when run,
 and the automated action also effectively creates the same thing as the xml here, which just needs to be a one-off, so if you've run that is the xml needed?

Conclusion here is that we need the scheduled task because there no way on cmd to automate turning off the 'don't run if on battery' setting, we can automate with powershell though....