#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Run script with macOS config (general settings)
sh $DIR/defaults/macos.sh

# Run script with Photos.app config
sh $DIR/defaults/photos.sh

# Run script with Safari.app config
sh $DIR/defaults/safari.sh

# Run script that sets the wallpaper
sh $DIR/defaults/wallpaper.sh

# Run script with iTerm2.app config
sh $DIR/defaults/iterm2.sh

# Run script with Transmission.app config
sh $DIR/defaults/transmission.sh

# Run script that creates symbolic links
sh $DIR/symlink/symlink.sh

# Install apps
sh $DIR/apps/apps.sh
