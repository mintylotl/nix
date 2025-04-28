#!/usr/bin/env bash
cd $HOME/.scripts/programs/musicbee

WINEPREFIX="$HOME"/.bottles/musicB PULSE_SINK=alsa-headphones $mbWINE "./.MusicBee/MusicBee.exe"
sudo -E ./prio.sh
