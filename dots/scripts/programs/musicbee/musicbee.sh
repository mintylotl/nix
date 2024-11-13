#!/usr/bin/env bash
#WINEPREFIX="/home/jwm/.musicbee" wine "/home/jwm/.musicbee/drive_c/programs/MusicBee/MusicBee.exe"&
cd $HOME/.scripts/programs/musicbee
WINEPREFIX="$HOME"/.bottles/musicB WINEFSYNC=1 PIPEWIRE_LATENCY=512/48000 wine "./.MusicBee/MusicBee.exe"
sudo -E ./prio.sh
