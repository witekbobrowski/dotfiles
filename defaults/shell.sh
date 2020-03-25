#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🐚'

# Change users shell to zsh
# log "$emoji Setting default shell to zsh"
# chsh -s /bin/zsh &> /dev/null

# Instal zsh highlighting plugin 
log "$emoji Instal zsh highlighting plugin"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
