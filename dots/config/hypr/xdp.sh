#!/usr/bin/env bash

if [ ! "$(pidof hypridle)" == "" ]; then
	killall hypridle
	hypridle &
else
	hypridle &
fi

if [ ! "$(pidof waybar)" == "" ]; then
	killall -SIGKILL waybar
	sleep 2s
	waybar &
else
	waybar &
fi
