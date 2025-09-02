#!/usr/bin/env bash
cd $HOME/.programs/musicbee

WINEPREFIX=$HOME/.bottles/musicB WINEDEBUG=-all PULSE_LATENCY_MSEC=100 $mbWINE ./.MusicBee/MusicBee.exe
sudo -E ./prio.sh
