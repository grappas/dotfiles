#!/usr/bin/env bash

if [ -n "$(pidof eww)" ]; then
  killall eww || killall .eww-wrapped
else
  eww open monitor1
  sleep 0.1
  eww open monitor2
fi
