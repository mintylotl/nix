#!/usr/bin/env bash

declare -A mountPoints
declare -A mountPointsCrypt
mountPointsCrypt[org]="${HOME}/.crypt/orgnotes"
mountPoints[org]="${HOME}/.orgnotes"

VOL="${1}"
VOLV=100

if [[ $VOL =~ ^[0-9]+$ ]]; then
    VOLV=$VOL
fi

echo "Mounting: ${mountPoints[$VOL]}"
mount --onlyonce -U 43EB-617A /pass

if [ $VOLV -eq 0 ]; then
    gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
    umount /pass/.pass
    umount /pass
    exit 0
elif [ $VOLV -eq 1 ]; then
    umount /pass/.pass
    umount /pass
    exit 0
fi

if [ -e /pass/.pass/passfile ]; then
    printf "already mounted!\n"
else
    gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
fi

tmpFile=$(mktemp)
chmod 600 "${tmpFile}"
chown jwm:root "${tmpFile}"
cat /pass/.pass/passfile | sudo -u jwm tee "${tmpFile}" >/dev/null

sudo -u jwm gocryptfs -passfile "${tmpFile}" "${mountPointsCrypt[$VOL]}" "${mountPoints[$VOL]}"

umount /pass/.pass
rm "${tmpFile}"
