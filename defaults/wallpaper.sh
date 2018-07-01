#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"
REPO_DIR="$( cd $( dirname $DIR ) && pwd)"
WALLPAPER_DIR=$REPO_DIR/misc/wallpaper

# Change wallpaper
echo "🖼 Setting new wallpaper"
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$WALLPAPER_DIR/mimirobson.png'"
killall Dock
