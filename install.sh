#!/bin/bash

# Create symbolic links for the dotfiles listed in symlink directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )""/symlink" && pwd )"

dotfiles=(".zshrc"
          ".gitconfig"
          ".phoenix.js")

for file in "${dotfiles[@]}"; do
  echo "🔗 "$file
  ln -f $DIR/$file ~/"$file"
done
