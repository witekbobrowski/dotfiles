#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"
REPO_DIR="$( cd $( dirname $DIR ) && pwd)"
ASSETS_DIR=$REPO_DIR/assets
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🌊'

# Change wallpaper
log "$emoji Setting new wallpaper"
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$ASSETS_DIR/mimirobson.png'"
killall Dock
