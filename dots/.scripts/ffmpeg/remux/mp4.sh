#!/usr/bin/env bash
for x in ./input/*
do
	ffmpeg -i "$x" -c:v copy -c:a libopus -b:a 88k -map 0:v -map 0:a ./output/"$(basename "$x")".mp4
done
