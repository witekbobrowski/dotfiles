#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=lib.sh
source "$DIR/lib.sh"

separator='================================================================================'

# Run script with shell config
sh "$DIR/defaults/shell.sh"

log "$separator"

# Run script with macOS config (general settings)
sh "$DIR/defaults/macos.sh"

log "$separator"

# Run script creating directories
sh "$DIR/defaults/directories.sh"

log "$separator"

# Run script with Photos.app config
sh "$DIR/defaults/photos.sh"

log "$separator"

# Run script with Safari.app config
sh "$DIR/defaults/safari.sh"

log "$separator"

# Run script that sets the wallpaper
# sh "$DIR/defaults/wallpaper.sh"

log "$separator"

# Run script with iTerm2.app config
sh "$DIR/defaults/iterm2.sh"

log "$separator"

# Run script with Transmission.app config
sh "$DIR/defaults/transmission.sh"

log "$separator"

# Run script that creates symbolic links
sh "$DIR/symlink/symlink.sh"

log "$separator"

# Install apps

echo "Install git lfs"
git lfs install

sh "$DIR/apps/apps.sh"
