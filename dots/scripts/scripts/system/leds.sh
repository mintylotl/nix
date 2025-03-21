#!/usr/bin/env bash

DEV=""
for x in /sys/class/leds/*;
do
    if printf "$x" | grep -q "scrolllock"
    then
        DEV=$(basename "$x")
    fi
done

while :
do
    brightnessctl -q --device="$DEV" set 1
    sleep 0.1s
done
