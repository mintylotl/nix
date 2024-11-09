#!/usr/bin/env bash
# Niceness for cpu priority
renice -n -14 -p $( pgrep -f wineserver )
renice -n -14 -p $( pgrep -f MusicBee.exe )
renice -n -17 -p $( pgrep -f pipewire-pulse )
renice -n -16 -p $( pgrep -f pipewire )
# Niceness for I/O Priority
ionice -c2 -n1 -p $( pgrep -f wineserver )
ionice -c2 -n1 -p $( pgrep -f MusicBee.exe )
ionice -c1 -n0 -p $( pgrep -f pipewire )
ionice -c1 -n0 -p $( pgrep -f pipewire-pulse )

