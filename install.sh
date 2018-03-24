#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Run scripts with default settings
sh $DIR/defaults/terminal.sh

# Run script that creates symbolic links
sh $DIR/symlink/symlink.sh

# Install apps
sh $DIR/apps/apps.sh
