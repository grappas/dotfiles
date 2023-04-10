#!/bin/sh
#
#
USAGE_VALUE="$1"

LOOP_LIMITER=$(( $USAGE_VALUE / 10 ))

echo -n "|"
seq 0 $LOOP_LIMITER | while read each
do
    if (( $each == 0 ))
    then
        echo -n ""
    else
        echo -n "█"
    fi
done

if (((  $USAGE_VALUE % 10  ) >= 5))
then
    echo -n "▌"
    LOOP_LIMITER=$(($LOOP_LIMITER + 1))
fi

REVERSE_LOOP_LIMITER=$((10-$LOOP_LIMITER))

seq 0 $REVERSE_LOOP_LIMITER | while read each
do
    if (( $each == 0 ))
    then
        echo -n ""
    else
        echo -n " "
    fi
done

echo -n "|"

