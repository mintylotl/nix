#!/usr/bin/env bash
cd "$HOME/.programs/musicbee/shortcuts"

WINDOW="$(./getWdName.sh)"
xdotool key --window "$WINDOW" "SUPER+Home"
