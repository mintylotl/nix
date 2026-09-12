#!/usr/bin/env bash

cd ~/.programs/gacha_life || exit 1

if [[ "$1" == 1 ]]; then
    pkill gacha
    # pkill vite
    exit
fi
./gacha

#cd ~/Proj/projects/gacha_life/gacha_ui/ui
#npm run dev
