#!/bin/sh

DEVICE="E5:5A:85:8E:22:22"

if [ -z "$(bluetoothctl devices Connected | grep "$DEVICE")" ]; then
    bluetoothctl connect "$DEVICE"
    sleep 1
fi

if [ ! -z "$(echo -e "menu player\nshow" | bluetoothctl | grep "Status: playing")" ]; then
    echo -e "menu player\npause" | bluetoothctl | grep "Status: playing"
else
    echo -e "menu player\nplay" | bluetoothctl | grep "Status: playing"
fi
