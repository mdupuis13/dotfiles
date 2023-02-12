#!/usr/bin/env bash

#lxsession &
# or 
#dex, DesktopEntry Execution, is a program to generate and execute DesktopEntry files of the Application type.
dex -va

#boot compton or picom if it exists
if [ -x "$(command -v compton)" ]; then
  compton &> /dev/null & 
elif [ -x "$(command -v picom)" ]; then
  picom &> /dev/null & 
fi

#set background
nitrogen --restore

# use redshift to shift colors at night
# redshift-gtk &

# desktop locking program "daemon"
/usr/bin/light-locker &

qbittorrent --no-splash &
