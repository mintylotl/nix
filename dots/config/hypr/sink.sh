#!/usr/bin/env bash

if systemctl --user status pipewire | grep -q "failed";
then
	echo Service Failed, Attempting a Restart...
	sleep 10s
	systemctl --user restart pipewire
fi

SCRIPT_DIR="/home/jwm/.config/hypr"
if systemctl --user status pipewire | grep -q "failed";
then
	echo Tried to fix pipewire but all attempts failed...
	echo Launching waybar...
	$SCRIPT_DIR/xdp.sh&
	$SCRIPT_DIR/startup.sh&
else
	echo Pipewire Launched Successfully...
	echo Launching waybar...
	"$SCRIPT_DIR"/xdp.sh&
	"$SCRIPT_DIR"/startup.sh&
fi
