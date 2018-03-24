#!/bin/bash

CURRENT_DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"
REPO_DIR="$( cd $( dirname $CURRENT_DIR ) && pwd)"
ITERM_DIR=$REPO_DIR/miscellaneous/iterm2

# Change users shell to zsh
echo "🛠 Setting default shell to zsh"
# chsh -s /bin/zsh

# Specify the preferences directory
echo "⛓  Setting default path to iTerm2 config plist file at $ITERM_DIR"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string $ITERM_DIR

# Tell iTerm2 to use the custom preferences in the directory
echo "⛓  Setting default default value to iTerm2 to load configuration from linked plist file"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
