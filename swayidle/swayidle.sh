#!/bin/sh
swayidle -d -w \
                timeout 240 "hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'" \
