#!/usr/bin/env bash

awk -F"[][]" '/Front Left:/ { printf $2 }' <(amixer sget Master)
