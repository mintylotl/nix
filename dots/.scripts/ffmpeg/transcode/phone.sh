#!/usr/bin/env bash

for x in ./input/*
do
	ffmpeg -i "$x" -c:v libx265 -preset fast -profile:v main10 -pix_fmt yuv420p10le -crf 26 -c:a libopus -b:a 88k -vbr on -compression_level 10 ./output/"$(basename "$x")".mkv
done
