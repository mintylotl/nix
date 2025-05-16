#!/usr/bin/env bash

read -p "1. Choice Machine\n2. Truth Machine" choice

if [ "1" == $choice ]; then
    python3 ./Choice_Machine.py
elif [ "2" == $choice ]; then
    python3 ./Truth_Machine.py
fi
