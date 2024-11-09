#!/usr/bin/env bash

NUM=$(cat ~/.config/hypr/.gamemode)
MODE=1

if [ $NUM -eq 1 ];
then
MODE=0
echo 0 > ~/.config/hypr/.gamemode
fi

if [ $MODE -eq 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword general:allow_tearing 1;\
        keyword decoration:rounding 0"
    echo 1 > ~/.config/hypr/.gamemode
    exit
fi
hyprctl reload
