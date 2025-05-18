#!/usr/bin/env bash

declare -A mountPoints
declare -A mountPointsCrypt
declare -A additionalArgs

mountPointsCrypt[org]="${HOME}/.crypt/orgnotes"
mountPoints[org]="${HOME}/.orgnotes"
mountPointsCrypt[camera]="/Drives/WD1TB/Archive/Camera/.crypt"
mountPoints[camera]="/Drives/WD1TB/Archive/Camera/Files"
mountPointsCrypt[gpt]="/Drives/WD1TB/Archive/Other/bak/chatgpt/.crypt"
mountPoints[gpt]="/Drives/WD1TB/Archive/Other/bak/chatgpt/Files"
additionalArgs[org]=" -noprealloc"

VOL="${1}"
VOLV=100
VOLVV=100

if [[ ! -v ${additionalArgs[$VOL]} ]]; then
    additionalArgs[$VOL]=""
fi

if [[ $VOL =~ ^[0-9]+$ ]]; then
    VOLV=$VOL
fi
if [ $VOLV -eq 3 ]; then
    for d in "${mountPoints[@]}"; do
        umount "$d"
    done
    exit 0
fi

if [[ $2 =~ ^[0-9]+$ ]]; then
    VOLVV=$2
fi
if [ $VOLVV -eq 1 ]; then
    umount "${mountPoints[$VOL]}"
    exit 0
fi

echo "Mounting: ${mountPoints[$VOL]}"
mount --onlyonce -U 43EB-617A /pass

if [ $? -eq 0 ]; then
    printf "Mounted Volume...\n"
else
    printf "Please insert USB key...\n"

    if [ $VOLV -eq 1 ]; then
        umount /pass/.pass
        umount /pass
    fi

    while :; do
        sleep 1s
        mount --onlyonce -U 43EB-617A /pass 2>/dev/null

        if [ $? -eq 0 ]; then
            break
        fi
    done
fi

if [ $VOLV -eq 0 ]; then
    gocryptfs -passfile /system/pass/usb /pass/.pass_crypt /pass/.pass
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

if [ -z $VOL ]; then
    for d in "${!mountPoints[@]}"; do
        echo $d
        sudo -u jwm gocryptfs${additionalArgs[$d]} -passfile "${tmpFile}" "${mountPointsCrypt[$d]}" "${mountPoints[$d]}"
    done
fi
sudo -u jwm gocryptfs${additionalArgs[$VOL]} -passfile "${tmpFile}" "${mountPointsCrypt[$VOL]}" "${mountPoints[$VOL]}"

rm "${tmpFile}"
umount /pass/.pass
umount /pass
