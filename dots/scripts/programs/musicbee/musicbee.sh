#!/usr/bin/env bash
cd $HOME/.scripts/programs/musicbee
WINEPREFIX="$HOME"/.bottles/musicB wine "./.MusicBee/MusicBee.exe"
sudo -E ./prio.sh
