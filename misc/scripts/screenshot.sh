#!/bin/sh

GRIMBLAST_DATE=$(date +'%d%m%y%H%M%S')

HYPRSHADE_CURRENT=$(hyprshade current | grep blue)

echo "$GRIMBLAST_DATE"
if [ ! -z $HYPRSHADE_CURRENT ]
then
    hyprshade off $HYPRSHADE_CURRENT && \
        grimblast copysave $@ ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png && pinta ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png && \
        hyprshade on $HYPRSHADE_CURRENT
else
        grimblast copysave $@ ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png && pinta ~/Obrazy/Zrzuty\ ekranu/"$GRIMBLAST_DATE".png
fi
