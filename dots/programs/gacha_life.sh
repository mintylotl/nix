#!/usr/bin/env bash

cd ~/.programs/gacha_life

if [[ "$1" == 1 ]]; then
    pkill gacha
    pkill vite
fi
cd gacha
cargo run &

cd ./../gacha_ui/ui
npm run dev
