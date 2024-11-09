#!/usr/bin/env bash

for x in ./input/*; do
	name="$(basename "$x")"
	ffmpeg -i "$x" -vn -c:a copy ./output/"${name%.*}".m4a
done
