#!/usr/bin/env bash
#WINEPREFIX="/home/jwm/.musicbee" wine "/home/jwm/.musicbee/drive_c/programs/MusicBee/MusicBee.exe"&
cd $HOME/.scripts/programs/musicbee
WINEPREFIX="$HOME"/.bottles/musicB WINEFSYNC=1 wine "./.MusicBee/MusicBee.exe"
sudo ./prio.sh
