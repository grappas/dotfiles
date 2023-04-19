#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/eww/cpu_usage.out)

echo "CPU:  $(sh ~/skrypty/eww/display_single_usage_bar.sh $CPU_USAGE_VALUE)   $(printf '%3.3s' "$CPU_USAGE_VALUE")%/$( printf '%4s' $(cat ~/temp/eww/cpu_frequency.out))MHz"

