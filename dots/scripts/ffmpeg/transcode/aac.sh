#!/usr/bin/env bash

for x in ./input/*; do
    ffmpeg -n -i "$x" -c:a libopus -b:a 192k -map 0:a:0 ./output/"$(basename "$x")".ogg
done
