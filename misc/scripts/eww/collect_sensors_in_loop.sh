#!/bin/sh
#
if [ ! -d ~/temp/eww ]
then
    mkdir -p ~/temp/eww
fi

while (true)
do
    sh ~/.config/eww/scripts/collect_sensors.sh
done
