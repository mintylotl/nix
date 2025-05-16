#!/usr/bin/env bash
# Check if program is running, if yes, kill tray
cd /home/jwm/.programs/musicbee
touch ./shortcuts/.startup
./musicbee.sh &
