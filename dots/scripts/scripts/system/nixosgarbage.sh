#!/usr/bin/env bash

for i in /nix/var/nix/gcroots/auto/*; do
    rm "$i"
done
nix-collect-garbage -d

nixos-rebuild boot --flake /etc/nixos#cabbage
