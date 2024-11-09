#!/usr/bin/env bash

for x in ./input/*
do
	ffmpeg -i "$x" -c:v libx264 -preset slow -pix_fmt yuv420p -crf 22 -c:a aac -b:a 256k -filter_complex "scale=720:-1:flags=lanczos[v]" -map "[v]" -map 0:a ./output/"$(basename "$x")".mp4
done
