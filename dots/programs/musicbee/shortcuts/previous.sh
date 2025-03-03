#!/usr/bin/env bash
cd "$HOME/.scripts/programs/musicbee/shortcuts"

WINDOW="$(./getWdName.sh)"
xdotool key --window "$WINDOW" "SUPER+SHIFT+Scroll_Lock"
