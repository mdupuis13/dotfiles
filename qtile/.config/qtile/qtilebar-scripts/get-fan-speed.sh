#!/bin/sh

cpufan=`sensors nct6798-isa-0290 | grep fan2 | awk '{ print $2 }'`
casefans=`sensors nct6798-isa-0290 | grep fan4 | awk '{ print $2 }'`
chipsetfan=`sensors nct6798-isa-0290 | grep fan5 | awk '{ print $2 }'`

echo -n "<span foreground=\"#61AFEF\">Fan speeds | CPU: $cpufan RPM - Case: $casefans RPM - chipset: $chipsetfan RPM</span>"
