#!/usr/bin/env bash

if [ -n "$(cat ~/instalancje/dotfiles/eww/eww.yuck | grep ":exclusive true")" ]; then
  sed -i 's/:exclusive true/:exclusive false/g' ~/instalancje/dotfiles/eww/eww.yuck
else
  sed -i 's/:exclusive false/:exclusive true/g' ~/instalancje/dotfiles/eww/eww.yuck
fi
