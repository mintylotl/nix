#!/usr/bin/env bash

if [ ! "$(pidof hypridle)" == "" ]; then
	killall hypridle
	hypridle &
else
	hypridle &
fi

if [ ! "$(pidof waybar)" == "" ]; then
	killall -SIGKILL waybar
	waybar &
fi
