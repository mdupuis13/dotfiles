#!/bin/sh

gpuwatts=`sensors amdgpu-pci-0c00 | grep PPT | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`

pctUsage=$(( ($gpuwatts * 100) / 230 )) 

echo -n " <span foreground=\"#61AFEF\">$pctUsage %</span>"