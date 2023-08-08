#!/usr/bin/env bash

awk -F"[][]" '/Rear Left:/ { printf $2 }' <(amixer sget Master)