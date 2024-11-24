#!/bin/sh

gpuMaxWatgts=230
gpuMaxFreq=2474

#gpuWatts=`sensors amdgpu-pci-0c00 | grep PPT | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`
#gpuPwr=`sensors amdgpu-pci-0c00 | grep sclk | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`

gpuUsage=`cat /sys/class/drm/card1/device/gpu_busy_percent`

#pctUsage=$(( $gpuPwr div gpuMaxFreq )) 

echo -n " <span foreground=\"#61AFEF\">$gpuUsage %</span>"