#!/usr/bin/env bash

#boot compton or picom if it exists
if [ -x "$(command -v compton)" ]; then
  compton &> /dev/null & 
elif [ -x "$(command -v picom)" ]; then
  picom &> /dev/null & 
fi

#lxsession &
# or 
#dex, DesktopEntry Execution, is a program to generate and execute DesktopEntry files of the Application type.
dex -va

redshift-gtk &
qbittorrent --no-splash &