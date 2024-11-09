#!/usr/bin/env bash
cd "$(pwd)"

eval $(ssh-agent)
ssh-add ~/.ssh/github_ssh.key

git commit -m $(date +'%Y-%m-%d_%H:%M:%S') -a
