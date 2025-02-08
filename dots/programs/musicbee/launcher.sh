#!/usr/bin/env bash
# Check if program is running, if yes, kill tray
cd /home/jwm/.scripts/programs/musicbee/
./musicbee.sh &
#while [ "$(pgrep -f MusicBee.exe)" == "" ]
#do
#sleep 1s
#done
#killall explorer.exe
