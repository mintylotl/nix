#!/usr/bin/env bash
DIR="$1"
FILE="$2"
exedir="/home/jwm/.wine/drive_c/Program Files/Mp3tag/Mp3tag.exe"

if [ "$FILE" == "" ]; then
	wine "$exedir" /fn:"$(winepath --windows "$DIR")"
else
	wine "$exedir" /fp:"$(winepath --windows "$DIR")"
fi
