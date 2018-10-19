#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🐚'

# Change users shell to zsh
log "$emoji Setting default shell to zsh"
chsh -s /bin/zsh &> /dev/null

