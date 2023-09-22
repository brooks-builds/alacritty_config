#!/bin/zsh

# We have updated the local version of our alacritty config, so we need to
# - overwrite the one here
# - upload to github
LOGFILE=script_out

echo "\n***** Running upload to github script *****\n" >> $LOGFILE

if [[ -f $HOME/.config/alacritty/alacritty.yml ]]; then
  echo "found alacritty config file"
else
  echo "could not find alacritty config"
  exit 1
fi

if git pull >> $LOGFILE; then
  echo "updated config from github"
else
  echo "failed to update from github"
  exit 2
fi

if cp $HOME/.config/alacritty/alacritty.yml ./alacritty.yml >> $LOGFILE; then
  echo "copied in alacritty config"
else
  echo "failed to copy in alacritty config"
  exit 3
fi

if [[ -v 1 && -n "$1" ]]; then
  COMMIT_MESSAGE=${1}
else 
  COMMIT_MESSAGE="updating alacritty config from local"
fi

if git commit -am "$COMMIT_MESSAGE" >> $LOGFILE; then
  echo "commited to git"
else
  echo "failed to commit new version of alacritty config"
  exit 4
fi

if git push >> $LOGFILE; then
  echo "pushed to github"
else
  echo "failed to push changes to github"
  exit 5
fi

echo "local alacritty config pushed to github"