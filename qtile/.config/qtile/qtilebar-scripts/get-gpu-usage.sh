#!/bin/sh

gpuwatts=`sensors amdgpu-pci-0c00 | grep PPT | awk '{ print $2 }' | awk 'BEGIN { FS = "." } ; { print $1}'`

echo -n " <span foreground=\"#61AFEF\">$gpuwatts W</span>"