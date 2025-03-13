#!/bin/sh
#
if [ ! -d /tmp/eww ]; then
    mkdir -p /tmp/eww
fi

while (true); do
    sh ~/.config/eww/scripts/collect_sensors.sh
done
