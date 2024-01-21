#!/bin/sh

GRIMBLAST_DATE=$(date +'%d%m%y%H%M%S')

if [ -z $(hyprshade current) ]
then
    hyprshade off $(hyprshade current) && \
        $@ && \
        hyprshade on $(hyprshade current)
else
    $@
fi
