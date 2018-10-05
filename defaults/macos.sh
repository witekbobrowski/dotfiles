#!/bin/bash

emoji="🎚    "

log() {
    prefix="$1"
    message="$2"
    echo "$prefix$message"
}

# macOS Config
log "$emoji" "Configuring macOS"

# Change users shell to zsh
log "$emoji" "Setting default shell to zsh"
chsh -s /bin/zsh

# Save screenshots to the Screenshots folder in Downloads
log "$emoji" "Setting location for screenshots to ~/Pictures/Screenshots/"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# Declutter desktop from icons for hard drives, servers, and removable media
log "$emoji" "Hiding icons for hard drives, servers and removable media on desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Disable Dashboard
log "$emoji" "Disabling Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

# Set the icon size of Dock items to 32 pixels
log "$emoji" "Setting Dock size to 32"
defaults write com.apple.dock tilesize -int 32

# Don’t show Dashboard as a Space
log "$emoji" "Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
log "$emoji" "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# Bottom left screen corner → Start screen saver
log "$emoji" "Set bottom left screen corner as screen saver hotkey"
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Put display to sleep
log "$emoji" "Set bottom right screen corner as put to display to sleep hotkey"
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

# Disable mouse acceleration
log "$emoji" "Set mouse acceleration ot -1 to diable it"
defaults write .GlobalPreferences com.apple.mouse.scaling -1
