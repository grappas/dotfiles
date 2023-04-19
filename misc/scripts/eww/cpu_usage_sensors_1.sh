#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/eww/cpu_usage.out)

echo "T: $(printf '%3s' $(cat ~/temp/eww/sensors.zenpower.temp))°C P: $(printf '%3s' $(cat ~/temp/eww/sensors.zenpower.power))W V: $(printf '%5.5s' $(cat ~/temp/eww/sensors.zenpower.voltage))V"

