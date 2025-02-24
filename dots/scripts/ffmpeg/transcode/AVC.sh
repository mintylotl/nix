#!/usr/bin/env bash

for x in ./input/*; do
    ffmpeg -i "$x" -c:v libx264 -preset faster -pix_fmt yuv420p -crf 19 -c:a libopus -b:a 256k -filter_complex "scale=1280:-1:flags=lanczos[v]" -map "[v]" -map 0:a:1 -map 0:s ./output/"$(basename "$x")".mkv
done
