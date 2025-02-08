#!/usr/bin/env bash

VALUES=$(xdotool search --pid $(pgrep -f MusicBee.exe))

for x in $VALUES;
do
	NAME="$(xdotool getwindowname $x)"

	if [[ "$NAME" == *"MusicBee"* ]];
	then
		echo "$x"
	fi
done
