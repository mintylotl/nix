#!/usr/bin/env bash
profile="$1"
mode=$2
purgemode=$3
resume=0
target="/tmp/firefoxsync"
date="$(date +'%Y-%m-%d_%H%M%S')"

cd /home/jwm/.mozilla/firefox
mkdir -p ./recover ./bak

function cleanup {
	countBakDir=0
	deleteDir="$1"
	delAmount=0
	count=0
	keep=$2

	for bak_dir in "$deleteDir"/*
	do
		countBakDir=$(($countBakDir+1))
		printf "$bak_dir\n"
	done
	
	if [ $countBakDir -gt $keep ]
	then
		printf "There are $countBakDir baks\n"
		printf "Deleting $(($countBakDir-$keep))\n"
	else
		return
	fi

	delAmount=$(($countBakDir-$keep))
	printf "$delAmount\n"
	for deldir in "$deleteDir"/*
	do
		if [ $count -eq $delAmount ]
		then
			break
		fi

		if [ ! "$deldir" == "" ] && [ ! "$deldir" == "/home/jwm/.mozilla/bak/*" ] && \
			[ ! "$deldir" == "/home/jwm/.mozilla/firefox/bak" ]
		then
			printf "Deleting $deldir\n"
			rm -rf "$deldir"
			count=$(($count+1))
		fi
	done
	return
}

function copy {
	sourc="$1"
	dest="$2"
	
	if [ ! -d $sourc ]
	then
		return
	fi

	rsync -ar "$sourc" "$dest"
	return
}

function suspend {
	if [ ! "$( pgrep firefox )" == "" ]
	then
		killall -STOP firefox
		printf "Momentarily suspended firefox\n"
	fi
	return
}

function resume {
	if [ ! "$( pgrep firefox )" == "" ]
	then
		killall -CONT firefox
		printf "Firefox Resumed\n"
	fi
	return
}

function recover {
	printf "Script was shutdown uncleanly last time!\n"
	printf "Attempting Recovery and Re-initializing...\n"

	numbak=0
	num=0
	folder_bak=""
	dir_loop="$1"
	for e in "$dir_loop"/*
	do
		numbak=$(($numbak+1))
	done

	if [ $numbak -eq 0 ]
	then
		printf "No Backups to Restore from\n"
		printf "Panic Quitting\n"
		exit
	fi

	for x in "$dir_loop"/*
	do
		num=$(($num+1))
		if [ $num -eq $numbak ]
		then
			folder_bak="$x"
			break
		fi
	done
	if [ -d $target ]
	then
		rm -rf $target
	fi
	copy "$folder_bak"/ Profiles
	printf "Recovery Successful!\n"
	return
}

function bak {
	if [ -d $target/$profile ]
	then
		suspend
		if [ ! -d bak/"$date"\($profile\) ]
		then
			copy $target/$profile bak/"$date"\($profile\)
		fi
		resume
	fi
	return
}

if [ $mode -eq 2 ]
then
	bak
	cleanup "/home/jwm/.mozilla/firefox/bak" 2

	if [ -L ./Profiles/$profile ]
	then
		printf "Link already exists!\n"
		if [ -d ./Profiles/$profile ]
		then
			printf "No further action needed.\n"
			printf "Leaving script\n"
			exit
		elif [ ! -d ./Profiles/$profile ]
		then
			recover "/home/jwm/.mozilla/firefox/bak"
		fi
	elif [ -d ./Profiles/$profile ]
	then
		printf "The Profile is being Synced...\n"
		copy Profiles/$profile bak/$date\($profile\)

	elif [ ! -d ./Profiles/$profile ]
	then
		printf "No Profile Found!!\n"
		recover "/home/jwm/.mozilla/firefox/bak"
	fi

elif [ $mode -eq 1 ]
then
	printf "Initiating Cleanup Procedure!!...\n"

	if [ -d $target/$profile ]
	then
		suspend
		rm -r ./Profiles/$profile
		copy $target/$profile Profiles
		rm -r $target
		printf "Profile Cleanup Went Smoothly!\n"
		resume
	elif [ ! -d $target/$profile ]
	then
		printf "No Profile to Restore!!\n"
		if [ -L ./Profiles/$profile ]
		then
			rm ./Profiles/$profile
		fi
		if [ -d $target ]
		then
			rm -r $target
		fi
	fi
	exit
else
	printf "Script Ran in an Incorrect Manner!!\n"
	printf "Quitting Script\n"
	exit
fi

if [ ! -d $target ]
then
	mkdir -p $target
	
	copy ./Profiles/$profile/ $target/$profile
	rm -r ./Profiles/$profile

	#cd /home/jwm/.cache/mozilla/firefox
	#copy Profiles/$profile/ $target/$profile/syncCache
	#rm -r Profiles/$profile
	#ln -s $target/$profile/syncCache Profiles/$profile
	#cd /home/jwm/.mozilla/firefox

	ln -s $target/$profile ./Profiles/$profile
else
	printf "The Directory Already Exists!!\n"
	if [ -d $target/$profile ]
	then
		copy $target/$profile recover/$date
	fi
	exit
fi
