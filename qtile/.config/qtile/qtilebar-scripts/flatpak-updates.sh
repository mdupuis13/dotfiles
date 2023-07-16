#!/bin/sh

prefix="ﰩ"

nbUpdates=`flatpak remote-ls --updates | wc -l`

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
        
echo -n "<span foreground=\"$foreground\">$nbUpdates $prefix </span>"
