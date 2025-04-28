#!/usr/bin/env bash
cd $HOME/.scripts/programs/musicbee

WINEPREFIX="$HOME"/.bottles/musicB PULSE_LATENCY_MSEC=1024 $mbWINE "./.MusicBee/MusicBee.exe"
sudo -E ./prio.sh
