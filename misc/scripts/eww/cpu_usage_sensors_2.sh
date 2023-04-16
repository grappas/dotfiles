#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/eww/cpu_usage.out)

echo "T: $(printf '%3s' $(cat ~/temp/eww/sensors.zenpower.temp))°C F: $( printf '%4s' $(cat ~/temp/eww/cpu_frequency.out))MHz"

