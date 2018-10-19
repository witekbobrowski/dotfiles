#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='📷'

# Photos.app
info "Configuaring Photos.app"

# Prevent Photos from opening automatically when devices are plugged in
log "$emoji Turn-off auto launch on plugging devices"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

success "Done configuaring Photos.app!"
