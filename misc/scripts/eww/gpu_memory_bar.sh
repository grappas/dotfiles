#!/bin/sh

GPU_USAGE_VALUE=$(( $( echo "$( cat /tmp/eww/gpu.vram.used )*100/$( cat /tmp/eww/gpu.vram.total )" | bc ) ))
GPU_FREQUENCY=$(cat /tmp/eww/gpu.vram.used)

echo "VRAM: $(sh ~/skrypty/eww/display_single_usage_bar.sh $GPU_USAGE_VALUE) $(printf '%5s' "$GPU_USAGE_VALUE")%/$(printf '%5.5s' "$GPU_FREQUENCY")M ​"
