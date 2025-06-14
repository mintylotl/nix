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
additionalArgs[org]="-noprealloc"

VOL="${1}"
VOLV=100
VOLVV=100

if [[ -z $VOL ]]; then
    VOL=""
fi

if [[ -n $VOL && ! -v additionalArgs[$VOL] ]]; then
    additionalArgs[$VOL]=""
fi

if [[ $VOL =~ ^[0-9]+$ ]]; then
    VOLV=$VOL
fi
if [ $VOLV -eq 3 ]; then
    for g in "${mountPoints[@]}"; do
        umount "$g"
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

if [ $VOLV -eq 1 ]; then
    printf 'Unmounting: USB Key\n'
    umount /pass/.pass
    umount /pass
    exit 0
fi
printf 'Mounting: USB Key with UUID:049B-44C5\n'
mount --onlyonce -U 049B-44C5 /pass

if [ $? -eq 0 ]; then
    printf "Mounted Volume...\n"
else
    printf "Please insert USB key...\n"

    while :; do
        sleep 1s
        mount --onlyonce -U 049B-44C5 /pass 2>/dev/null

        if [ $? -eq 0 ]; then
            break
        fi
    done
fi
printf 'Done\n'

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

if [ -z "$VOL" ]; then
    for d in "${!mountPoints[@]}"; do
        if ! [[ -v additionalArgs[$d] ]]; then
            additionalArgs[$d]=""
        fi
        sudo -u jwm gocryptfs ${additionalArgs[$d]} --quiet -passfile $tmpFile ${mountPointsCrypt[$d]} ${mountPoints[$d]}
        printf 'Mount Successful: %s \n' "$d"
    done

    umount /pass/.pass && sleep 3s && umount /pass &
    exit 0
fi

sudo -u jwm gocryptfs ${additionalArgs[$VOL]} --quiet -passfile $tmpFile ${mountPointsCrypt[$VOL]} ${mountPoints[$VOL]}
printf 'Mount Successful: %s \n' "$VOL"

rm "${tmpFile}"
umount /pass/.pass && sleep 3s && umount /pass &
