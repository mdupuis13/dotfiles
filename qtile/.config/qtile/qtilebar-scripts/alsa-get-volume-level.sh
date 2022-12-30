#!/usr/bin/env bash

awk -F"[][]" '/Left:/ { printf $2 }' <(amixer sget Master)