#!/usr/bin/env bash
number=0

while :
do

if [ -f $(pwd)/shallow ];
then
number=$(($number + 6))
git fetch --depth $number
else
exit
fi

done
