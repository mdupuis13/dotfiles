#!/bin/sh

prefix=""

nbUpdates=`zypper -t -q list-updates | wc -l`
#nbUpdates=`eval $(expr $nbUpdates - 3)`

        foreground="#a3be8c"
        if [ "$nbUpdates" -le 5 ]; then
            foreground="#a3be8c"
        elif [ "$nbUpdates" -le 10 ]; then
            foreground="#e5c07b"
        elif [ "$nbUpdates" -le 15 ]; then
            foreground="#fab387"
        elif [ "$nbUpdates" -le 20 ]; then
            foreground="#e06c75"
        elif [ "$nbUpdates" -le 30 ]; then
            foreground="#c678dd"
        else foreground="#ef3d59"
        fi
        
echo -n "<span foreground=\"$foreground\"><span size=\"26pt\" rise=\"-6pt\">$prefix</span> $nbUpdates </span>"
