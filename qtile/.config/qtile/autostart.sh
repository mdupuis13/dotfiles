#!/usr/bin/env bash

# change screen layout
#sleep 1
echo Changing screen layout...
/home/mdupuis/.screenlayout/default-dp2.sh
#/home/mdupuis/.screenlayout/dp1et2.sh

echo Setting backgrounds
#sleep 0.5
nitrogen --restore

echo map multimedia keys
/usr/bin/xbindkeys &

echo lxsession start
lxsession &
# or 
#dex, DesktopEntry Execution, is a program to generate and execute DesktopEntry files of the Application type.
echo dex autostart
dex --autostart &

echo start gnome-keyring 
# It should start from PAM (/etc/pam.d) or even /etc/xdg/autostart (via dex), but apparently it does not
gnome-keyring-daemon --replace --components=pkcs11,secrets,ssh &

#boot compton or picom if it exists
#if [ -x "$(command -v compton)" ]; then
#  compton &> /dev/null & 
#elif [ -x "$(command -v picom)" ]; then
picom -b
#  picom -b --experimental-backends --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 & 2>&1 /dev/null
#fi

# use redshift to shift colors at night
# redshift-gtk &

# desktop locking program "daemon"
/usr/bin/light-locker &

qbittorrent --no-splash &
solaar --window=hide &
