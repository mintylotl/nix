#!/usr/bin/env bash

export SYNC_PORT="37322"
export SYNC_USER1="Anki:85878"
export SYNC_BASE="/home/jwm/.AnkiSync"
#export SYNC_ENDPOINT_MEDIA="http://127.0.0.1:27701/msync/"

anki --syncserver

