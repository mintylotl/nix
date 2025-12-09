#!/usr/bin/env sh

while :; do
    if mountpoint 2>/dev/null >/dev/null; then
        echo Proceeding With Cleanup...
        break
    else
        sleep 3s
    fi
done
rm -r /home/Games/Games500G/\$RECYCLE.BIN
rm -r /home/Games/Games500G/System\ Volume\ Information
echo "Games500G Cleaned"

rm -r /Drives/WD1TB/\$RECYCLE.BIN
rm -r /Drives/WD1TB/System\ Volume\ Information
echo "WD1TB Cleaned"
printf "\n done \n"
