#!/bin/zsh

HASH_BEFORE_PULL=$(git rev-parse HEAD)
git pull > /dev/null
HASH_AFTER_PULL=$(git rev-parse HEAD)

if [[ "$HASH_BEFORE_PULL" != "$HASH_AFTER_PULL" ]]; then
  cp ./alacritty.yml ~/.config/alacritty/alacritty.yml
  echo "installed latest version of alacritty config"
fi
