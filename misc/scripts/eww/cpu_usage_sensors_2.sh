#!/bin/sh
#
CPU_USAGE_VALUE=$(cat /tmp/eww/cpu_usage.out)

echo "T: $(printf '%3s' $(cat /tmp/eww/sensors.zenpower.temp))°C F: $( printf '%4s' $(cat /tmp/eww/cpu_frequency.out))MHz"

