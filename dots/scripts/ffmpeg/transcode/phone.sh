#!/usr/bin/env bash

for x in ./input/*; do
    ffmpeg -i "$x" -c:v libx264 -preset fast -profile:v main -pix_fmt yuv420p -crf 26 -c:a libopus -b:a 88k -vbr on -compression_level 10 ./output/"$(basename "$x")".mp4
done
