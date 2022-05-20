#!/usr/bin/env bash

#set -xe

updates=$(apt list --upgradable 2> /dev/null | grep -c upgradable);

echo $updates
