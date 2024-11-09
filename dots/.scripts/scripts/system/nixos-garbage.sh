#!/usr/bin/env bash
rm /nix/var/nix/gcroots/auto/*
nix-collect-garbage -d
