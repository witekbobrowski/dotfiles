#!/bin/bash

CURRENT_DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Create symbolic links for the dotfiles listed in symlink directory
SYMLINK_DIR=$CURRENT_DIR/symlink

dotfiles=(".zshrc"
          ".gitconfig"
          ".phoenix.js")

echo "Creating symbolic links for files from $SYMLINK_DIR"
for file in "${dotfiles[@]}"; do
  echo "🔗  $file"
  ln -f $SYMLINK_DIR/$file ~/"$file"
done

# Install apps
APPS_DIR=$CURRENT_DIR/apps

which -s brew
if [[ $? != 0 ]] ; then
  echo "🛠  Installing homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "🛠  Installing homebrew apps"
cat $APPS_DIR/Brewfile | xargs brew install
echo "🛠  Installing homebrew-cask apps"
cat $APPS_DIR/Caskfile | xargs brew cask install
echo "🛠  Installing yarn apps"
cat $APPS_DIR/Yarnfile | xargs yarn global add
echo "🛠  Installing gem apps"
cat $APPS_DIR/Gemfile | xargs sudo gem install
echo "🛠  Installing MacAppStore apps"
grep "^[^#]" $APPS_DIR/Masfile | xargs mas install
