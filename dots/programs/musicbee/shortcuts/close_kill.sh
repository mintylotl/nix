#!/usr/bin/env bash

cd "$HOME/.scripts/programs/musicbee/shortcuts" || exit
WINDOW="$(./getWdName.sh)"

xdotool key --window "$WINDOW" "Delete"
sleep 1s

VALUE="$(ps aux | grep "explorer" | grep -v "grep" | awk '{print $2}')"
if [[ "$VALUE" != "" && -e ./.startup ]]; then
    kill -9 $VALUE
    rm ./.startup
fi
