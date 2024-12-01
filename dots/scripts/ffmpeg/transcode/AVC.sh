#!/usr/bin/env bash

for x in ./input/*; do
    ffmpeg -i "$x" -c:v libx264 -preset superfast -pix_fmt yuv420p -crf 24 -c:a libopus -b:a 60k -filter_complex "scale=1280:-1:flags=lanczos[v]" -map "[v]" -map 0:a ./output/"$(basename "$x")".mkv
done
