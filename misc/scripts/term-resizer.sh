#!/bin/sh

# This script will resize fonts inside the terminal according to size of its window.
# usage: term-resizer.sh <term> <nominal_width> <nominal_height> <font_size>
# term: the class of the terminal, e.g. "foot"
# nominal_width: the width of window on its default font size
# nominal_height: the height of window on its default font size
# font_size: the default font size of the terminal
# jq and ydotool are required for this script to work.

TERM="$1"
NOMINAL_WIDTH="$2"
NOMINAL_HEIGHT="$3"
FONT_SIZE=$4 # distribute for both width and height
W_STEP_SIZE=$((NOMINAL_WIDTH / FONT_SIZE))
H_STEP_SIZE=$((NOMINAL_HEIGHT / FONT_SIZE))

>/tmp/term-resizer-cache.txt

while true; do
	# init gc
	cat /tmp/term-resizer-cache.txt >/tmp/term-resizer-gc.txt
	# get all info about the terminals
	GATHER_TERMINALS=$(hyprctl -j clients | jq '.[] | select(.class=="'${TERM}'")')

	# strip the addresses and loop through them
	echo "$GATHER_TERMINALS" | jq '.address' | while read address; do
		# check if window exists in the cache
		if [ -z "$(cat /tmp/term-resizer-cache.txt | grep $address)" ]; then
			echo "$address $NOMINAL_WIDTH $NOMINAL_HEIGHT" >>/tmp/term-resizer-cache.txt
		fi
		# get the width and height of the terminal
		WIDTH=$(echo "$GATHER_TERMINALS" | jq -r 'select(.address=='$address') | .size[0]')
		HEIGHT=$(echo "$GATHER_TERMINALS" | jq -r 'select(.address=='$address') | .size[1]')

		# script's logic

		cat /tmp/term-resizer-cache.txt | grep $address | while read each width height; do
		if [ "$WIDTH" -ne "$width" ] || [ "$HEIGHT" -ne "$height" ]; then

			WDELTA=$(($WIDTH - $width))
			HDELTA=$(($HEIGHT - $height))

			W_NO_STEPS=$(($WDELTA / $W_STEP_SIZE))
			H_NO_STEPS=$(($HDELTA / $H_STEP_SIZE))
			NO_STEPS=$(($W_NO_STEPS + $H_NO_STEPS))
			echo "$address $NO_STEPS"

			ADDRESS_CACHE=$(echo "$address" | sed 's/\"//g')

			if [ $NO_STEPS -gt 0 ]; then
				hyprctl keyword bind CONTROL,code:21,pass,address:$ADDRESS_CACHE
				seq 1 $NO_STEPS | while read _; do
					ydotool key -d 10 29:1 13:1 13:0 29:0
				done
				hyprctl keyword unbind CONTROL,code:21
			elif [ $NO_STEPS -lt 0 ]; then
				hyprctl keyword bind CONTROL,code:20,pass,address:$ADDRESS_CACHE
				seq 1 $(($NO_STEPS * -1 ))| while read _; do
					ydotool key -d 10 29:1 12:1 12:0 29:0
				done
				hyprctl keyword unbind CONTROL,code:20
			fi

			NEW_CACHE=$(cat /tmp/term-resizer-cache.txt | sed 's/'"$address"'.*$/'$address'\ '$WIDTH'\ '$HEIGHT'/')
			echo "$NEW_CACHE" >/tmp/term-resizer-cache.txt
		fi
		done

		# delist from gc
		GARBAGE_COLLECTOR=$(cat /tmp/term-resizer-gc.txt | grep -v "$address")
		echo "$GARBAGE_COLLECTOR" >/tmp/term-resizer-gc.txt
	done

	# remove old entries from cache
	if [ -n "$(cat /tmp/term-resizer-gc.txt)" ]; then
		cat /tmp/term-resizer-gc.txt | while read each width height; do
			GARBAGE_COLLECTOR=$(cat /tmp/term-resizer-cache.txt | grep -v "$each")
			echo "$GARBAGE_COLLECTOR" >/tmp/term-resizer-cache.txt
		done
	fi
	sleep 1
done
