#!/bin/sh
#
CORE_COUNTER=0

CORE_COUNTER_MAX=$(grep ^cpu\\scores /proc/cpuinfo | uniq | awk '{print $4}')

if ( ($CORE_COUNTER_MAX >10)); then
    DAMN_THERES_MORE=1
else
    DAMN_THERES_MORE=0
fi

>~/temp/eww/cpu_usage_per_core_bar_collection
cat ~/temp/eww/mpstat.out.per_core_raw | while read A B; do
    if ( ($A <= $B)); then
        MAX_USAGE=$B
    else
        MAX_USAGE=$A
    fi

    CORE_FREQUENCY=$(cat ~/temp/eww/zenmonitor.out | grep "Core $CORE_COUNTER Frequency" | sed 's/^.*Frequency\t//g' | sed 's/\.//g')
    PRINT_BAR=$(sh ~/.config/eww/scripts/display_double_usage_bar.sh $A $B)

    if [ $DAMN_THERES_MORE = 1 ]; then
        LINE_TO_PRINT=$(echo "C $(printf '%2s' $CORE_COUNTER) |$PRINT_BAR| $(printf '%3s' $MAX_USAGE)% $(printf '%4.4s' $CORE_FREQUENCY)MHz")
    else
        LINE_TO_PRINT=$(echo "C $CORE_COUNTER |$PRINT_BAR| $(printf '%3s' $MAX_USAGE)% $(printf '%4.4s' $CORE_FREQUENCY)MHz")
    fi
    echo "$LINE_TO_PRINT" >>~/temp/eww/cpu_usage_per_core_bar_collection
    CORE_COUNTER=$(($CORE_COUNTER + 1))
done

cat ~/temp/eww/cpu_usage_per_core_bar_collection
