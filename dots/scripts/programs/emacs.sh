#!/usr/bin/env bash
sleep 15s

. ~/.profile
. ~/.bashrc
emacsDir="/home/jwm/.emacs.d"

"$emacsDir/bin/doom" sync
systemctl --user restart emacs
