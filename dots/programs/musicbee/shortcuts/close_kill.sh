#!/usr/bin/env bash

cd "$HOME/.programs/musicbee/shortcuts" || exit
WINDOW="$(./getWdName.sh)"

xdotool key --window "$WINDOW" "SUPER+Delete"
sleep 1s

VALUE="$(ps aux | grep "explorer" | grep -v "grep" | awk '{print $2}')"
if [[ "$VALUE" != "" && -e ./.startup ]]; then
    kill -9 $VALUE
    rm ./.startup
fi
