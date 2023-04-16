#!/bin/sh
MEM_PERCENTAGE_RAW=""
MEM_PERCENTAGE=""
MEM_VALUE=""

LANG=en top -bn1 -w 120 | grep "MiB Mem" | while read MiB Mem colon WHOLE_VALUE total FREE_VALUE free USED_VALUE used BUFFERED_VALUE buff
do
    MEM_PERCENTAGE_RAW=$( echo "$USED_VALUE*100/$WHOLE_VALUE" | bc )
    MEM_PERCENTAGE=$(echo "$MEM_PERCENTAGE_RAW"% )
    if (("$(echo $USED_VALUE | wc -c)" >= 6 ))
    then
        MEM_VALUE=$(echo "$(echo $USED_VALUE | sed 's/....$//g' | sed -r 's/.$/\.&/')G")
    else
        MEM_VALUE=$(echo "$USED_VALUE"M )
    fi
    printf 'MEM:  %s %4.4s/%-6.6s​' "$( sh ~/.config/eww/scripts/display_single_usage_bar.sh $MEM_PERCENTAGE_RAW )" $MEM_PERCENTAGE $MEM_VALUE
done
