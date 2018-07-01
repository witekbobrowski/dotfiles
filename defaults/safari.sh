#!/bin/bash

# Safari.app
echo "🛠 Configuring Safari.app"

# Privacy: don’t send search queries to Apple
echo "🛠 Disaple sending search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
echo "🛠 Show full url"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
echo "🛠 Set `about:blank` as homepage"
defaults write com.apple.Safari HomePage -string "about:blank"

# Hide Safari’s bookmarks bar by default
echo "🛠 Hide bookmarks"
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
echo "🛠 Hide sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
echo "🛠 Disable thumbnail cache"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
echo "🛠 Enavle Safari debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Warn about fraudulent websites
echo "🛠 Warnd about fraudelent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
echo "🛠 Disaple plugins"
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
echo "🛠 Disable Java"
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
echo "🛠 Block popup windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
echo "🛠 Enable \"Do Not Track\""
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
echo "🛠 Update extensions automarically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
