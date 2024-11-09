#!/usr/bin/env bash

sleep 5s
if systemctl --user status pipewire | grep -q "failed";
then
	echo Service Failed, Attempting a Restart...
	num=0
	comp="name: HD-Audio Generic"
	while [ $num -lt 3 ]
	do
		hw=$(alsactl info hw:$num | grep -w "name: HD-Audio Generic")
		hw=$(echo $hw | sed 's/"  "//g')
		if [ "$hw" == "$comp" ]
		then
			for i in {0..2}
			do
				if [ ! $num -eq $i ]
				then
					sed -i "s/hw:$i/hw:$num/g" "/home/jwm/.config/pipewire/pipewire.conf"
				fi
			done
			break
		fi
		num=$(($num + 1))
	done
	sleep 2s
	systemctl --user restart pipewire
fi

SCRIPT_DIR="/home/jwm/.config/hypr"
if systemctl --user status pipewire | grep -q "failed";
then
	echo Tried to fix pipewire but all attempts failed...
	echo Launching waybar...
	echo All operations Completed
	$SCRIPT_DIR/startup.sh&
else
	echo Pipewire Launched Successfully...
	echo Launching waybar...
	echo All operations Completed
	"$SCRIPT_DIR"/xdp.sh&
	"$SCRIPT_DIR"/startup.sh&
fi
