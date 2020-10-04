# Install
Just run 1.ChocsAway.bat from its current location, which will determine you don't have chocolatey installed, or the desktop shortcut for itself, and install both before running.
No need to run anything as administrator, all that's worked out for you

# Usage
Then we run it when we want to install/update choco apps (it runs as administrator), the script allows you massages the packages list 'packages.config' before chocolatey runs.
It uses powershell (new process in same window) for querying and uses configurable editor (Notepad++) to open the packages.config

# Other features
The WhatDoIHaveInstalled folder is for info only - if you didn't use a config file and if you hadn't set up from scratch,
you could use this to generate an install script from your existing choco installs

# Limitations
The current imp will update ALL choco installed packages, not just those from your package list, but this also has the advantage that it updates choco itself

# Help
* for chocoloatey you should run cinst --whatif package to find package info, as running choco info isn't too useful 
(don't forget to run manual choco commands in elevated prompt)
* if you interrupt or if some other problem, I have found that choco uninstall and then a cinst doesn't work. 
	The fix is to go here: C:\ProgramData\chocolatey\lib and manually delete the affected package

* The choclately wiki is here: https://github.com/chocolatey/choco/wiki
* In that wiki is the following command reference:

Commands

    list / search - searches and lists remote or local packages
    install - installs packages from various sources
    installmissing - REMOVED
    update - DEPRECATED - RESERVED for future use (You are looking for upgrade, these are not the droids you are looking for)
    outdated - show a list of packages that have updates (similar to choco upgrade --noop, but only outputs out of date packages, current version and available update version).
    upgrade - upgrades packages from various sources
    version - DEPRECATED - will be removed in v1 - use choco upgrade <pkg|all> -whatif instead
    uninstall - uninstalls a package
    help - REMOVED - use -h on any command.

Commands (intermediate to advanced)

    config - Retrieve and configure config file settings
    source / sources - view and configure default sources
    apikey / setapikey - retrieves or saves an apikey for a particular source
    pin - suppress upgrades to a package

Package Creation Commands

    new - generates files necessary for a Chocolatey package
    pack - packages up a nuspec to a compiled nupkg
    push - pushes a compiled nupkg

Default Options and Switches

-?, --help, -h
  Prints out the help menu.

-d, --debug
  Debug - Run in Debug Mode.

-v, --verbose
  Verbose - See verbose messaging.

--acceptlicense, --accept-license
  AcceptLicense - Accept license dialogs automatically.

-y, --yes, --confirm
  Confirm all prompts - Chooses default answer instead of prompting.
  Implies --accept-license

-f, --force
  Force - force the behavior

--noop, --whatif, --what-if
  NoOp - Don't actually do anything.

-r, --limitoutput, --limit-output
  LimitOuptut - Limit the output to essential information

--execution-timeout=VALUE
  CommandExecutionTimeoutSeconds - Override the default execution
  timeout in the configuration of 2700 seconds.

-c, --cache, --cachelocation, --cache-location=VALUE
  CacheLocation - Location for download cache, defaults to %TEMP% or
  value in chocolatey.config file.

--allowunofficial, --allow-unofficial, --allowunofficialbuild,
--allow-unofficial-build
  AllowUnofficialBuild - When not using the official build you must set
  this flag for choco to continue.

How To Pass Options / Switches

You can pass options and switches in the following ways:

    Unless stated otherwise, an option/switch should only be passed one time. Otherwise you may find weird/non-supported behavior.
    -, /, or -- (one character switches should not use --)
    Option Bundling / Bundled Options: One character switches can be bundled. e.g. -d (debug), -f (force), -v (verbose), and -y (confirm yes) can be bundled as -dfvy.
    Note: If debug or verbose are bundled with local options (not the global ones above), some logging may not show up until after the local options are parsed.
    Use Equals: You can also include or not include an equals sign = between options and values.
    Quote Values: When you need to quote an entire argument, such as when using spaces, please use a combination of double quotes and apostrophes ("'value'"). In cmd.exe you can just use double quotes ("value") but in powershell.exe you should use backticks (`"value`") or apostrophes ('value'). Using the combination allows for both shells to work without issue, except for when the next section applies.
    Pass quotes in arguments: When you need to pass quoted values to to something like a native installer, you are in for a world of fun. In cmd.exe you must pass it like this: -ia "/yo=""Spaces spaces""". In PowerShell.exe, you must pass it like this: -ia '/yo=""Spaces spaces""'. No other combination will work. In PowerShell.exe if you are on version v3+, you can try --% before -ia to just pass the args through as is, which means it should not require any special workarounds.
    Options and switches apply to all items passed, so if you are installing multiple packages, and you use --version=1.0.0, choco is going to look for and try to install version 1.0.0 of every package passed. So please split out multiple package calls when wanting to pass specific options.
