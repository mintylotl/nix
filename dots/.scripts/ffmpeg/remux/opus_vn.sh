#!/usr/bin/env bash

for x in ./input/*
do
	name="$(basename "$x")"
	ffmpeg -i "$x" -vn -c:a copy ./output/"${name%.*}".ogg
done
