#!/usr/bin/env bash

declare -A mountPoints
declare -A mountPointsCrypt
mountPointsCrypt[org]="${HOME}/.crypt/orgnotes"
mountPoints[org]="${HOME}/.orgnotes"

VOL="${0}"

mount -U 43EB-617A /pass

if [[ "$0" == "" || "$0" == " " ]]; then
    gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
    exit 0
elif [[ "$0" -eq 1 ]]; then
    umount /pass/.pass
fi

gocryptfs -passfile /pass/.pass/passfile "${mountPointsCrypt[$VOL]}" "${mountPoints[$VOL]}"
