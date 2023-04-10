#!/bin/sh
#
CPU_USAGE_VALUE=$(cat ~/temp/cpu_usage.out)

echo "P: $(printf '%3s' $(cat ~/temp/sensors.zenpower.power))W V: $(printf '%5.5s' $(cat ~/temp/sensors.zenpower.voltage))V"

