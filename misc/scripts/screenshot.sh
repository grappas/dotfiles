#!/bin/sh

GRIMBLAST_DATE=$(date +'%d%m%y%H%M%S')

HYPRSHADE_CURRENT=$(hyprshade current | grep blue)

echo "HYPRSHADE_CURRENT: $HYPRSHADE_CURRENT"
if [ ! -z $HYPRSHADE_CURRENT ]
then
    hyprshade toggle $HYPRSHADE_CURRENT
    grimblast copysave $@ ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png
    pinta ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png&
    hyprshade toggle $HYPRSHADE_CURRENT
else
    grimblast copysave $@ ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png && pinta ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png&
fi
