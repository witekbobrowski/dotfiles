#!/bin/bash

# Photos.app
echo "🛠 Configuaring Photos.app"

# Prevent Photos from opening automatically when devices are plugged in
echo "🛠 Turn-off auto launch on plugging devices"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
