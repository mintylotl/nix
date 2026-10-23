#!/usr/bin/env bash

while true; do
    if curl -fsS -H "X-Emby-Token: 439a3015243c4ae2b8cab0a2fa7b482d" 
        http://localhost:8096/Sessions |
        jq -e 'any(.[]; .NowPlayingItem != null and .PlayState.IsPaused != true)' >/dev/null; then
        systemd-inhibit --what=sleep:idle 
            --why="Jellyfin streaming" sleep 30
    else
        sleep 10
    fi
done
