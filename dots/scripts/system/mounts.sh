#!/usr/bin/env bash
MODE=0

mountpoint /Drives/WD1TB
if [[ $? -eq 0 ]]; then
	if [ $MODE -eq 0 ]; then
		exit 0
	fi
fi

if [[ $1 =~ ^[1-9]$ ]]; then
	MODE=$1
fi

HOME="/home/jwm"
COLD="d7f41dd1-ef48-427f-9f65-94e1016c0b13"
HOT="8f29f7cf-0bea-45a9-945c-9c35e9ac41da"
MED="bc53d224-cdf4-4d0d-a328-9731266e5220"

if [ $MODE -eq 1 ]; then
	mount --onlyonce -t btrfs -U $HOT -o subvol=@vols/emacs-conf $HOME/.doom.d/
	#mount --onlyonce -t btrfs -U $HOT -o compress-force=zstd:3,noatime,subvol=@vols/emacs $HOME/.emacs.d/
	mount --onlyonce -t btrfs -U $HOT -o subvol=@vols/orgnotes,compress=zstd:3,noatime $HOME/.crypt/orgnotes
	/system/scripts/usb_crypt.sh org
	exit 0
fi

COUNTER=0
while :; do
	mount -U $COLD /Drives/WD1TB -o subvol=@Files
	if [ $? -eq 0 ]; then
		printf 'Drive Found...\n'
		break
	fi

	COUNTER=$((COUNTER + 1))
	if [[ $COUNTER -eq 10 ]]; then
		printf 'Error Loading Drive\nUUID %s Not Found...\n' "$COLD" >&2
		exit 1
	fi
	sleep 5s
done

lnID="$(blkid | grep 'UUID="d7f41dd1-ef48-427f-9f65-94e1016c0b13"' | grep -o '/dev/sd[a-z][1-9]*')"
lnID_DISK="$(printf "$lnID" | sed 's/1//g')"

# APM
printf "Setting APM Params...\n"
hdparm -B 111 -S 245 $lnID_DISK
printf "\nParams Set Successfully...\n\n"

# Mounts
# --Cold Storage
printf "Mounting 1TB HDD...\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@Files,compress=zstd:3,space_cache=v2,rw /Drives/WD1TB/
printf "Mounted Files\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/prod,compress-force=zstd:7,noatime /Drives/WD1TB/Production/
printf "Mounted Prod\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/archive,compress=no /Drives/WD1TB/Archive/
printf "Mounted Archive\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/games,compress=no,rw,noatime /Drives/WD1TB/Archive/Games/
printf "\nMounted\n\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/projects,compress-force=zstd:1,noatime /Drives/WD1TB/Projects/

# --DoomEmacs
printf "Mounting DoomEmacs...\n"
mount --onlyonce -t btrfs -U $HOT -o subvol=@vols/emacs-conf $HOME/.doom.d/
mount --onlyonce -t btrfs -U $HOT -o compress-force=zstd:3,noatime,subvol=@vols/emacs $HOME/.emacs.d/
mount --onlyonce -t btrfs -U $HOT -o subvol=@vols/orgnotes,compress=zstd:3,noatime $HOME/.crypt/orgnotes
printf "\nMounted\n\n"

# --Crypts
printf "Mounting Encrypted Volumes...\n"
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/crypt/vol_camera /Drives/WD1TB/Archive/Camera/.crypt
mount --onlyonce -t btrfs -U $COLD -o subvol=@vols/crypt/vol_gptchats /Drives/WD1TB/Archive/Other/bak/chatgpt/.crypt

printf "Symlinking\n"
# --Cold Storage
rm /dev/wdd
rm /dev/wd

ln -s "$lnID_DISK" /dev/wd
printf "Linked $lnID to '/dev/wd'\n"

ln -s "$lnID" /dev/wdd
printf "Linked $lnID_DISK to '/dev/wdd'"

printf "\n\nDone"
