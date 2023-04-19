#!/bin/sh
#cat /sys/class/drm/card0/device/pp_dpm_sclk | grep \* | sed 's/Mh.*$//g' | sed 's/^.*:\ //g'

max_freq() {
    local F_COUNT=0
    cat /sys/class/drm/card0/device/pp_dpm_sclk | { while read each
do
    F_COUNT=$(($F_COUNT+1))
done

F_COUNT=$(($F_COUNT-1))
echo $F_COUNT
}
}

declare FREQUENCY_VALUE=0
declare PERCENTAGE_VALUE=0

F_COUNT=$(max_freq)

if [ ! -f ~/temp/eww/gpu.frequency.max ]
then
    MAX_FREQUENCY=$(cat /sys/class/drm/card0/device/pp_dpm_sclk | grep "$F_COUNT": | sed 's/Mh.*$//g' | sed 's/^.*:\ //g' )
    cat /sys/class/drm/card0/device/pp_dpm_sclk | grep "$F_COUNT": | sed 's/Mh.*$//g' | sed 's/^.*:\ //g' > ~/temp/eww/gpu.frequency.max
fi


MAX_FREQUENCY_TEMP1=$(cat /sys/class/drm/card0/device/pp_dpm_sclk | grep "$F_COUNT": | sed 's/Mh.*$//g' | sed 's/^.*:\ //g' )
MAX_FREQUENCY_TEMP2=$(cat ~/temp/eww/gpu.frequency.max)
if (( $MAX_FREQUENCY_TEMP1 > $MAX_FREQUENCY_TEMP2))
then
    echo "$MAX_FREQUENCY_TEMP1" > ~/temp/eww/gpu.frequency.max
    MAX_FREQUENCY=$MAX_FREQUENCY_TEMP1
else
    MAX_FREQUENCY=$( cat ~/temp/eww/gpu.frequency.max )
fi

seq 0 9 | while read each
do
    sleep 0.1
    PERCENTAGE_VALUE=$(($(cat /sys/class/drm/card0/device/gpu_busy_percent)+$PERCENTAGE_VALUE))
    FREQUENCY_VALUE=$(echo "$FREQUENCY_VALUE+$(cat /sys/class/drm/card0/device/pp_dpm_sclk | grep \* | sed 's/Mh.*$//g' | sed 's/^.*:\ //g' | sort | uniq)" | bc )
    if (($each == 9))
    then
        AND_THE_PERCENTAGE_VALUE_IS=$(echo "$PERCENTAGE_VALUE/10" | bc)
        AND_THE_FREQUENCY_VALUE_IS=$(echo "$FREQUENCY_VALUE/10" | bc)
        AND_THE_VALUE_IS="$AND_THE_PERCENTAGE_VALUE_IS"
        # AND_THE_VALUE_IS=$(echo "$AND_THE_FREQUENCY_VALUE_IS*$AND_THE_PERCENTAGE_VALUE_IS/($MAX_FREQUENCY-( $MAX_FREQUENCY-(($AND_THE_FREQUENCY_VALUE_IS/100)*$AND_THE_PERCENTAGE_VALUE_IS )))" | bc)
        echo "$AND_THE_FREQUENCY_VALUE_IS" > ~/temp/eww/gpu_frequency.out
        echo "$AND_THE_VALUE_IS" > ~/temp/eww/gpu.usage
    fi
done
