#!/usr/bin/env bash

declare -A mountPoints
declare -A mountPointsCrypt
mountPointsCrypt[org]="${HOME}/.crypt/orgnotes"
mountPoints[org]="${HOME}/.orgnotes"

VOL="${1}"
if [[ "$VOL" == "" || "$VOL" == " " ]]; then
    VOL=0
fi
if [[ "${VOL}" == "org" ]]; then
    for _f in "${HOME}/.orgnotes/"*; do
        umount /pass/.pass
        exit 0
    done
fi

echo $1
echo ${mountPoints[org]}
echo ${mountPointsCrypt[org]}

mount --onlyonce -U 43EB-617A /pass

if [[ "$VOL" -eq 0 ]]; then
    gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
    exit 0
elif [ "$VOL" -eq 1 ]; then
    umount /pass/.pass
    exit 0
fi

gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
gocryptfs -passfile /pass/.pass/passfile "${mountPointsCrypt[$VOL]}" "${mountPoints[$VOL]}"

umount /pass/.pass
