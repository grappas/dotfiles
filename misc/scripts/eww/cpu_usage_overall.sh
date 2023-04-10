#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/cpu_usage.out)

echo "CPU:  $(sh ~/skrypty/eww/display_single_usage_bar.sh $CPU_USAGE_VALUE) $(printf '%5s' "$CPU_USAGE_VALUE")%"

