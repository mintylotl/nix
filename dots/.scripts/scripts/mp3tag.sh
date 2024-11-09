#!/usr/bin/env bash
DIR="$1"
FILE="$2"
exedir="/home/jwm/.wine/drive_c/Program Files/Mp3tag/Mp3tag.exe"

if [ "$FILE" == "" ];
then
	wine64 "$exedir" /fn:"$(winepath --windows "$DIR")"
else
	wine64 "$exedir" /fp:"$(winepath --windows "$DIR")"
fi

