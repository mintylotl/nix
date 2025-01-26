#!/usr/bin/env bash

count=3
state_sink="$(wpctl status)"
state="$(systemctl --user status pipewire)"
config="$(cat ~/.config/pipewire/pipewire.conf)"

if echo "$state" | grep -q "failed" || ! echo "$state_sink" | grep -q "33. Headphones"; then
	echo Service Failed, Attempting a Restart...
	sleep 10s
	for x in /sys/bus/pci/devices/0000:2d:00.4/sound/card*; do
		while :; do
			if [ "${x: -1}" == "$count" ]; then
				rm ~/.config/pipewire/pipewire.conf
				echo "$config" | sed "s/hw:[0-9]/hw:$count/g" >~/.config/pipewire/pipewire.conf
				sed -i "s/hw:[0-9]/hw:$count/g" /etc/nixos/dots/config/pipewire/pipewire.conf
			fi

			if [ $count -lt 1 ]; then
				break
			else
				count=$(($count - 1))
			fi
		done
	done

	systemctl --user restart pipewire
	sleep 5s
	rm ~/.config/pipewire/pipewire.conf
fi

SCRIPT_DIR="/home/jwm/.config/hypr"
if systemctl --user status pipewire | grep -q "failed"; then
	echo Tried to fix pipewire but all attempts failed...
	echo Launching waybar...
	$SCRIPT_DIR/xdp.sh &
	$SCRIPT_DIR/startup.sh &
else
	echo Pipewire Launched Successfully...
	echo Launching waybar...
	"$SCRIPT_DIR"/xdp.sh &
	"$SCRIPT_DIR"/startup.sh &
fi
