#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='📂'

function create_directory_if_needed() {
    if [ -d "$1" ]; then
        log "$emoji Directory '$1' is already created"
    else
        log "$emoji Creating '$1' directory"
        mkdir "$1"
    fi
}

info "Creating basic directories."

# Screenshots 
create_directory_if_needed "$HOME/Pictures/Screenshots"

# Developer
create_directory_if_needed "$HOME/Developer"

# Developer/personal 
create_directory_if_needed "$HOME/Developer/personal"

# Developer/work 
create_directory_if_needed "$HOME/Developer/work"

# Developer/temp 
create_directory_if_needed "$HOME/Developer/temp"

success "Done creating basic directories!"
