#!/usr/bin/env bash
renice -n -13 $( pidof MusicBee.exe )
ionice -c1 -n0 -p $( pidof MusicBee.exe )
