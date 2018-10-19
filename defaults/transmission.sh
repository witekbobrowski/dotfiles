#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='☠️ '

# Transmission.app
info "Configuring Transmission.app"

# Use `~/Documents/Torrents` to store incomplete downloads
log "$emoji Use '~/Documents/Torrents' to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

# Use `~/Downloads` to store completed downloads
log "$emoji Use '~/Downloads' to store completed downloads"
defaults write org.m0k.transmission DownloadLocationConstant -bool true

# Don’t prompt for confirmation before downloading
log "$emoji Don’t prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Don’t prompt for confirmation before removing non-downloading active transfers
log "$emoji Don’t prompt for confirmation before removing non-downloading active transfers"
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Trash original torrent files
log "$emoji Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
log "$emoji Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
log "$emoji Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
log "$emoji Load in block list"
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Randomize port on launch
log "$emoji Randomize port on launch"
defaults write org.m0k.transmission RandomPort -bool true

success "Done configuring Transmission.app!"
