#!/usr/bin/env bash
for i in input/*.mkv;
do
	tmpbasename="${i##*/}"
	tmpname=${tmpbasename%.mkv}
	name="${tmpname}"

	cp ./input/"$name".en.vtt ./input/"$name".vtt
	rm ./input/"$name".en.vtt
	ffmpeg -i "$i" -i ./input/"$name".vtt -c:v copy -c:a copy -c:s ssa -map 0:a -map 0:v -map 1:s:0 -default_mode infer_no_subs ./output/"$name".mkv
done
