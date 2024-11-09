#!/usr/bin/env bash
for i in input/*;
do
	namebase="${i##*/}"
	basenam="${namebase%.*}"
	ffmpeg -i "$i" -c:a pcm_s16le -ar 44100 output/"$basenam".wav
done
