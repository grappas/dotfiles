#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/cpu_usage.out)

echo "T: $(printf '%3s' $(cat ~/temp/sensors.zenpower.temp))°C F: $( printf '%4s' $(cat ~/temp/cpu_frequency.out))MHz"

