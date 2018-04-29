#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Create symbolic links for the dotfiles from this directory
echo "Creating symbolic links for files from $DIR"

ZSH=".zshrc"
echo "🔗  $ZSH"
ln -f $DIR/$ZSH ~/$ZSH

NVIM="init.vim"
echo "🔗  $NVIM" 
ln -f $DIR/$NVIM ~/.config/nvim/$NVIM

GIT=".gitconfig"
echo "🔗  $GIT"
ln -f $DIR/$GIT ~/$GIT

PHOENIX=".phoenix.js"
echo "🔗  $PHOENIX"
ln -f $DIR/$PHOENIX ~/$PHOENIX

