#!/bin/sh
#
USAGE_VALUE_A="$1"
USAGE_VALUE_B="$2"

if ((( $USAGE_VALUE_A % 10 ) >= 5))
then
    USAGE_VALUE_A=$(($USAGE_VALUE_A + 10))
fi

if ((( $USAGE_VALUE_B % 10 ) >= 5))
then
    USAGE_VALUE_B=$(($USAGE_VALUE_B + 10))
fi

LOOP_LIMITER_A=$(($USAGE_VALUE_A/10))
LOOP_LIMITER_B=$(($USAGE_VALUE_B/10))

if (($LOOP_LIMITER_A>=$LOOP_LIMITER_B))
then
    LOOP_LIMITER="$LOOP_LIMITER_A"
    OFF_LIMIT="▀"
else
    LOOP_LIMITER="$LOOP_LIMITER_B"
    OFF_LIMIT="▄"
fi

if (($LOOP_LIMITER > 0))
then
    for each in $(seq 1 $LOOP_LIMITER)
    do
        if ((($LOOP_LIMITER_A>=$each)&&($LOOP_LIMITER_B>=$each)))
        then
            BAR_APPENDANCE+="█"
        else
            BAR_APPENDANCE+="$OFF_LIMIT"
        fi
    done
fi

REVERSE_LOOP_LIMITER=$((10-$LOOP_LIMITER))

if (($REVERSE_LOOP_LIMITER > 0))
then
    for each in $(seq 1 $REVERSE_LOOP_LIMITER)
    do
        BAR_APPENDANCE+="—"
    done
fi

echo "$BAR_APPENDANCE"
