#!/bin/sh

echo "T:$(printf '%3.2s' "$(cat ~/temp/eww/sensors.amdgpu.temp)")°C P: $(printf '%3.3s' "$(cat ~/temp/eww/sensors.amdgpu.power)")W V: $(printf '%5.5s' "$(cat ~/temp/eww/sensors.amdgpu.vdd)")V"
