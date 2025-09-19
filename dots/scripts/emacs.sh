#!/usr/bin/env bash

while ! mountpoint "$HOME/.emacs.d"; do
    sleep 2s
done
exit 0
