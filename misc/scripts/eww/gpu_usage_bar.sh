#!/bin/sh

GPU_USAGE_VALUE=$(cat ~/temp/eww/gpu.usage)
GPU_FREQUENCY=$(cat ~/temp/eww/gpu_frequency.out)

echo "GPU:  $(sh ~/skrypty/eww/display_single_usage_bar.sh $GPU_USAGE_VALUE) $(printf '%5s' "$GPU_USAGE_VALUE")%/$(printf '%4.4s' "$GPU_FREQUENCY")MHz"
