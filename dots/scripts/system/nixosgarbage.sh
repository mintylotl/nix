#!/usr/bin/env bash

if [ $1 -eq 0 ]; then
    for x in /nix/var/nix/gcroots/auto/*; do
        rm "$x"
    done

    nix-collect-garbage -d
    nixos-rebuild boot --flake /etc/nixos#cabbage

else
    nix-collect-garbage -d
    #nixos-rebuild boot --fast --flake /etc/nixos#cabbage
fi
