#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Create symbolic links for the dotfiles from this direcotry
dotfiles=(".zshrc" ".gitconfig" ".phoenix.js")

echo "Creating symbolic links for files from $DIR"
for file in "${dotfiles[@]}"; do
  echo "🔗  $file"
  ln -f $DIR/$file ~/"$file"
done
