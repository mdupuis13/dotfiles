#!/bin/sh

cpufan=`sensors nct6798-isa-0290 | grep fan2 | awk '{ print $2 }'`
casefans=`sensors nct6798-isa-0290 | grep fan4 | awk '{ print $2 }'`
chipsetfan=`sensors nct6798-isa-0290 | grep fan5 | awk '{ print $2 }'`

echo -n "<span foreground=\"#61AFEF\"> <span size=\"20pt\" rise=\"-4pt\">󰈐</span> <span size=\"16pt\" rise=\"-2pt\"></span>$cpufan 󰇅$casefans <span size=\"16pt\" rise=\"-2pt\"></span>$chipsetfan</span>"
