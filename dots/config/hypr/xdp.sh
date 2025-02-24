#!/usr/bin/env bash

if [ ! "$(pidof hypridle)" == "" ]; then
	killall hypridle
	hypridle &
else
	hypridle &
fi

for x in $(pidof waybar); do
	kill -SIGKILL $x
done

waybar &
