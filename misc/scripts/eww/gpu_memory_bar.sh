#!/bin/sh

GPU_USAGE_VALUE=$(( $( echo "$( cat ~/temp/eww/gpu.vram.used )*100/$( cat ~/temp/eww/gpu.vram.total )" | bc ) ))
GPU_FREQUENCY=$(cat ~/temp/eww/gpu.vram.used)

echo "VRAM: $(sh ~/skrypty/eww/display_single_usage_bar.sh $GPU_USAGE_VALUE) $(printf '%5s' "$GPU_USAGE_VALUE")%/$(printf '%5.5s' "$GPU_FREQUENCY")M ​"
