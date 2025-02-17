#!/usr/bin/env bash
if [ ! "$(pidof hypridle)" == "" ]; then
	killall hypridle
	hypridle &
else
	hypridle &
fi

waybar &
