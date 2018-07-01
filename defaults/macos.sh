#!/bin/bash

# macOS Config
echo "Configuring macOS"

# Change users shell to zsh
echo "🛠 Setting default shell to zsh"
chsh -s /bin/zsh

# Save screenshots to the Screenshots folder in Downloads
echo "🛠 Setting location for screenshots to ~/Downloads/Screenshots/"
defaults write com.apple.screencapture location -string "${HOME}/Downloads/Screenshots"

# Declutter desktop from icons for hard drives, servers, and removable media
echo "🛠 Hiding icons for hard drives, servers and removable media on desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Disable Dashboard
echo "🛠 Disabling Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

# Set the icon size of Dock items to 32 pixels
echo "🛠 Setting Dock size to 32"
defaults write com.apple.dock tilesize -int 32

# Don’t show Dashboard as a Space
echo "🛠 Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
echo "🛠 Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# Bottom left screen corner → Start screen saver
echo "🛠 Set bottom left screen corner as screen saver hotkey"
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Put display to sleep
echo "🛠 Set bottom right screen corner as put to display to sleep hotkey"
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0
