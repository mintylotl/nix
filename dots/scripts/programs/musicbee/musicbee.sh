#!/usr/bin/env bash
cd $HOME/.scripts/programs/musicbee
WINEPREFIX="$HOME"/.bottles/musicB PULSE_LATENCY_MS=100 wine "./.MusicBee/MusicBee.exe"
sudo -E ./prio.sh
