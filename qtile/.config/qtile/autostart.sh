#!/usr/bin/env bash

# change screen layout
#sleep 1
autorandr desktop
#/home/mdupuis/.screenlayout/default.sh

# map multimedia keys
/usr/bin/xbindkeys &

lxsession &
# or 
#dex, DesktopEntry Execution, is a program to generate and execute DesktopEntry files of the Application type.
dex -va &

# start gnome-keyring 
# It should start from PAM (/etc/pam.d) or even /etc/xdg/autostart (via dex), but apparently it does not
gnome-keyring-daemon --replace --components=pkcs11,secrets,ssh &

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
/usr/bin/light-locker &


qbittorrent --no-splash &
solaar --window=hide &
