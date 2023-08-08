#!/usr/bin/env bash

# change screen layout
/home/mdupuis/.screenlayout/default.sh

# or 
#dex, DesktopEntry Execution, is a program to generate and execute DesktopEntry files of the Application type.
#dex -va

#boot compton or picom if it exists
#if [ -x "$(command -v compton)" ]; then
#  compton &> /dev/null & 
#elif [ -x "$(command -v picom)" ]; then
#  picom -b --experimental-backends --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 & 2>&1 /dev/null
#fi

#set background
#nitrogen --restore

# use redshift to shift colors at night
# redshift-gtk &

# desktop locking program "daemon"
#/usr/bin/light-locker &

#qbittorrent --no-splash &
