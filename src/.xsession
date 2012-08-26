#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources
 
# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 12 &
 
# Set the background color<
 
xsetroot -solid midnightblue
 
# Fire up apps
 
pidgin &

dropbox start &
 
xscreensaver -no-splash &
 
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
if [ -x /usr/bin/fdpowermon ] ; then
    sleep 3
    fdpowermon &
fi
 
exec xmonad
