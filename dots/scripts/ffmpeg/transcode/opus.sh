#!/usr/bin/env bash

for x in ./input/*; do
    ffmpeg -i "$x" -c:a libopus -compression-level 8 -cutoff 0 -b:a 192k "output/$(basename "$x")".opus
done
