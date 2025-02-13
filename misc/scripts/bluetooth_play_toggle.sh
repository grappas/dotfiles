#!/bin/sh

DEVICE="14:99:3E:DC:09:75"

if [ -z "$(bluetoothctl devices Connected | grep "$DEVICE")" ]; then
    bluetoothctl connect "$DEVICE"
    sleep 1
fi

if [ ! -z "$(echo -e "menu player\nshow" | bluetoothctl | grep "Status: playing")" ]; then
    echo -e "menu player\npause" | bluetoothctl | grep "Status: playing"
else
    echo -e "menu player\nplay" | bluetoothctl | grep "Status: playing"
fi
