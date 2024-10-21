#!/bin/sh

prefix=""

#nbUpdates=`zypper -q list-updates -t package -t patch | wc -l`
nbUpdates=`pkcon get-updates | grep "Enhancement" | wc -l`
#nbUpdates=$(($nbUpdates-5))
#echo "nbUpdates is $nbUpdates"

        foreground="#a3be8c"
        if [ "$nbUpdates" -le 250 ]; then
            foreground="#a3be8c"
        elif [ "$nbUpdates" -le 400 ]; then
            foreground="#e5c07b"
        elif [ "$nbUpdates" -le 500 ]; then
            foreground="#fab387"
        elif [ "$nbUpdates" -le 600 ]; then
            foreground="#e06c75"
        elif [ "$nbUpdates" -le 750 ]; then
            foreground="#c678dd"
        else foreground="#ef3d59"
        fi
        
echo -n "<span foreground=\"$foreground\"><span size=\"26pt\" rise=\"-6pt\">$prefix</span> $nbUpdates </span>"
