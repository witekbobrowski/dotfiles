#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🐚'

# Change users shell to zsh
# log "$emoji Setting default shell to zsh"
# chsh -s /bin/zsh &> /dev/null

# install oh-my-zsh
# log "$emoji install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instal zsh highlighting plugin 
log "$emoji Instal zsh highlighting plugin"
PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ -d "$PLUGIN_DIR" ]; then
    log "$emoji zsh-syntax-highlighting already installed"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR"
fi

