#!/bin/sh

gpufans=`sensors amdgpu-pci-0c00 | grep fan1 | awk '{ print $2 }'`

echo -n "<span foreground=\"#61AFEF\">Fan speeds | GPU: $gpufans</span>"

