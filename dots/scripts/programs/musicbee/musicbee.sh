#!/usr/bin/env bash
#WINEPREFIX="/home/jwm/.musicbee" wine "/home/jwm/.musicbee/drive_c/programs/MusicBee/MusicBee.exe"&
cd $HOME/.scripts/programs/musicbee
WINEPREFIX="$HOME"/.bottles/musicB wine "./.MusicBee/MusicBee.exe"

