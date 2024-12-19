#!/usr/bin/env bash

xdotool key --window $( xdotool search --limit 1 --pid $( pgrep -f MusicBee.exe ) ) "Delete"
