#!/bin/sh
swayidle -d -w \
                timeout 240 'hyprctl dispatch dpms off' \
