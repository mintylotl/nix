#!/usr/bin/env bash

for x in ./input/*
do
	if [ ! -d "$x" ]
	then
		tmpbasename="${x##*/}"
		basenamex="${tmpbasename%.*}"
		ffmpeg -i "$x" -vn -c:a libopus -b:a 256k -compression_level 10 -cutoff 0 -vbr on ./output/"$basenamex".ogg
	fi
done
