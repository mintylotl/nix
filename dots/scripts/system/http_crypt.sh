#!/usr/bin/env bash

# Codes:
# id is the array key used for the fs
#
# id + 1 = unmount fs
# id + no argument = mount fs
# 0 / no argument = mount all defined dirs (fs)
# 3 = unmount all defined dirs
# 4 = Server Status Report

declare -A mountPoints
declare -A mountPointsCrypt
declare -A additionalArgs

mountPointsCrypt[org]="${HOME}/.crypt/orgnotes"
mountPointsCrypt[camera]="/Drives/WD1TB/Archive/Camera/.crypt"
mountPointsCrypt[gpt]="/Drives/WD1TB/Archive/Other/bak/chatgpt/.crypt"
mountPointsCrypt[dreams]="/Drives/WD1TB/Archive/Other/bak/misc/Dreams/.crypt"

credentials="iA6oV*L2V@FQYsMiN*MRJBGu"
endpoint="https://11.0.0.3:8987/files"

for j in "${!mountPointsCrypt[@]}"; do
    mountPoints[$j]="${mountPointsCrypt[$j]}/../Files"
done
mountPoints[org]="${HOME}/.orgnotes"
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
if [ $VOLV -eq 4 ] && curl -u "pass:$credentials" "$endpoint" 2>/dev/null 1>&2; then
    printf 'Server Reachable\n'
    exit 0
elif [ $VOLV -eq 4 ]; then
    printf 'Server Unreachable\n'
    exit 0
fi
if [ $VOLV -eq 3 ]; then
    for g in "${mountPoints[@]}"; do
        if echo $g | grep -q "orgnotes" && sudo -u jwm mountpoint "$g" >/dev/null; then
            umount "$g"
            printf 'Successfully Unmounted %s\n' "org"
        fi
        if sudo -u jwm mountpoint "$g" >/dev/null; then
            umount "$g"
            printf 'Successfully Unmounted %s\n' $(echo "$g" | awk -F/ '{print $(NF-3)}')
        fi
    done
    exit 0
fi

if [[ $2 =~ ^[0-9]+$ ]]; then
    VOLVV=$2
fi
if [ $VOLVV -eq 1 ]; then
    umount "${mountPoints[$VOL]}"
    exit 0
else
    if curl -u "pass:$credentials" $endpoint/.pass/passfile >/dev/null 2>&1; then
        printf 'Server Active, Starting Mounts\n'
    else
        printf 'Server not responding. Abort!\n'
        exit 0
    fi
fi

curl -u "pass:$credentials" "$endpoint" 2>/dev/null | grep -wq "confirmation"
curlStat=$?
if [ $curlStat -eq 0 ]; then
    printf 'Please grant access by confirmation...\n'
    while :; do
        curl -u "pass:$credentials" "$endpoint" 2>/dev/null | grep -wq "confirmation"
        if [[ $? -eq 0 ]]; then
            sleep 1s
        else
            break
        fi
    done
fi

tmpFile=$(mktemp)
# Make first tmpfile containing encrypted passfile
chmod 600 "${tmpFile}"
curl -u "pass:$credentials" "$endpoint"/.pass/passfile 2>/dev/null | tee "${tmpFile}" >/dev/null

#Decrypt passfile to new temp location for usage
tmpOld="$tmpFile"
tmpFile=$(mktemp)
chmod 600 "$tmpFile"
cat /system/pass/usb | gpg --batch --passphrase-fd 0 -d "$tmpOld" 2>/dev/null | tee "$tmpFile" >/dev/null

if [ -z "$VOL" ]; then
    for d in "${!mountPoints[@]}"; do
        if ! [[ -v additionalArgs[$d] ]]; then
            additionalArgs[$d]=""
        fi
        cat "${tmpFile}" | sudo -u jwm gocryptfs ${additionalArgs[$d]} --quiet ${mountPointsCrypt[$d]} ${mountPoints[$d]}
        printf 'Mount Successful: %s \n' "$d"
    done
    exit 0
fi

cat $tmpFile | sudo -u jwm gocryptfs ${additionalArgs[$VOL]} --quiet ${mountPointsCrypt[$VOL]} ${mountPoints[$VOL]}
printf 'Mount Successful: %s \n' "$VOL"

rm "${tmpFile}"
rm "${tmpOld}"
