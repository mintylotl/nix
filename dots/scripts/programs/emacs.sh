#!/usr/bin/env bash
. ~/.profile
. ~/.bashrc

doom sync
systemctl --user restart emacs
