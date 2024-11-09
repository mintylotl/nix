#!/usr/bin/env bash
for x in ./input/*
do
	if [ ! -d "$x" ]
	then
		basename="${x##*/}"
		name="${basename%.*}"

		ffmpeg -i "$x" -filter_complex "scale=1920:-1:flags=lanczos[v]" -map 0:a -map "[v]" -c:a libopus -b:a 256k -compression_level 10 -cutoff 0 -c:v libx265 -preset medium -pix_fmt yuv420p10le -profile:v main10 -x265-params "crf=24:selective-sao=0:nosao=1:bf=3:keyint=15:min-keyint=4:psy-rd=1.0:0.15:deblock=-1:-1:aq-mode=3" ./output/"$name".mkv
	fi
done
