#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Run script with default terminal config
sh $DIR/defaults/terminal.sh

# Run script that sets the wallpaper
sh $DIR/defaults/wallpaper.sh

# Run script that creates symbolic links
sh $DIR/symlink/symlink.sh

# Install apps
sh $DIR/apps/apps.sh
