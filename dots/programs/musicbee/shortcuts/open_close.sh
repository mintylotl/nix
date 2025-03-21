#!/usr/bin/env bash

cd "$HOME/.scripts/programs/musicbee/shortcuts" || exit
WINDOW="$(./getWdName.sh)"

xdotool key --window "$WINDOW" "SUPER+Delete"
sleep 1s
