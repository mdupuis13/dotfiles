#!/bin/sh

gpuMaxWatgts=230
gpuMaxFreq=2474

gpuwatts=`sensors amdgpu-pci-0c00 | grep PPT | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`
gpuPct=`sensors amdgpu-pci-0c00 | grep sclk | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`

pctUsage=$(( $gpuPct*100 / gpuMaxFreq )) 

echo -n " <span foreground=\"#61AFEF\">$pctUsage %</span>"