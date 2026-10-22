#!/usr/bin/env bash

set -euo pipefail

cd /home/jwm/.config/bg
dir="${1:-.}"

for file in "$dir"/*; do
    [[ -f "$file" ]] || continue

    ext="${file##*.}"

    while :; do
        number=$(od -An -N8 -tu8 /dev/urandom | tr -d ' ')
        new="$dir/$number.$ext"

        [[ ! -e "$new" ]] && break
    done

    mv -- "$file" "$new"
done

