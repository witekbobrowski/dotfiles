#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🕸 ' 

# Safari.app
info "Configuring Safari.app"

# Privacy: don’t send search queries to Apple
log "$emoji Disable sending search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
log "$emoji Show full url"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
log "$emoji Set 'about:blank' as homepage"
defaults write com.apple.Safari HomePage -string "about:blank"

# Hide Safari’s bookmarks bar by default
log "$emoji Hide bookmarks"
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
log "$emoji Hide sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
log "$emoji Disable thumbnail cache"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
log "$emoji Enavle Safari debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Warn about fraudulent websites
log "$emoji Warnd about fraudelent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
log "$emoji Disaple plugins"
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
log "$emoji Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
log "$emoji Block popup windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
log "$emoji Enable \"Do Not Track\""
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

#Update extensions automatically
log  "$emoji Update extensions automarically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

success "Done configuring Safari.app!"

