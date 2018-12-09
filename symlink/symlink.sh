#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🔗'

# Create symbolic links for the dotfiles from this directory
info "Creating symbolic links for configuration files."

ZSH=".zshrc"
log "$emoji Linking $ZSH"
ln -f "$DIR/$ZSH" "$HOME/$ZSH"

NVIM="init.vim"
log "$emoji Linking $NVIM"
ln -f "$DIR/$NVIM" "$HOME/.config/nvim/$NVIM"

GIT=".gitconfig"
log "$emoji Linking $GIT"
ln -f "$DIR/$GIT" "$HOME/$GIT"

PHOENIX=".phoenix.js"
log "$emoji Linking $PHOENIX"
ln -f "$DIR/$PHOENIX" "$HOME/$PHOENIX"

RANGER="ranger/rc.conf"
log "$emoji Linking $RANGER"
ln -f "$DIR/$RANGER" "$HOME/.config/$RANGER"
~/.config/ranger/rc.conf
success "Done creating symbolic links!"
