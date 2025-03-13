#!/bin/sh
#
CPU_USAGE_VALUE=$(cat /tmp/eww/cpu_usage.out)

echo "T: $(printf '%3s' $(cat /tmp/eww/sensors.zenpower.temp))°C P: $(printf '%3s' $(cat /tmp/eww/sensors.zenpower.power))W V: $(printf '%5.5s' $(cat /tmp/eww/sensors.zenpower.voltage))V"

