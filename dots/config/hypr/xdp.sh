#!/usr/bin/env bash
if [ ! "$( pidof hypridle )" == "" ]
then
	killall hypridle
	hypridle&
else
	hypridle&
fi

if ! systemctl --user status pipewire | grep -q "failed";
then
	GDK_BACKEND=wayland waybar
fi
