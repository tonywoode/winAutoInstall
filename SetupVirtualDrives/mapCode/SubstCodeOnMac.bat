:: makes sure we have a drive O: that maps to code on osx
:: needs to be run every startup
:: problem is it lives on o: ;-)
:: so needs to be copied to all users startup (which you can find
:: with windows+R and then typing shell:common startup

:: remove any previous mappings (though there shouldn't be any as nothing here is perm)
net use O: /D
subst /D O:

::three cases are 1)river 2)native boot on pond and 3) parallels boot on pond
:: The last case is interesting, we CAN actually subst a network drive we map 
::  like (subst O: Z:\Users\twoode\CODE), but then opening any executables on the 
::  resulting drive kicks off windows smartscreen every time. So just make
::  the Mac drive available on the parallels 'network' and we net use it instead.

if exist E:\CODE (subst O: E:\CODE)
if exist E:\Users\twoode\CODE (subst O: E:\Users\twoode\CODE)
if exist "\\Mac\Macintosh HD\Users\twoode\CODE" (net use O: "\\Mac\Macintosh HD\Users\twoode\CODE") || echo "can't map the network code drive"

