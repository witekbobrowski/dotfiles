#!/bin/bash

DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd)"

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
  echo "🛠  Installing homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install packages from pm-specific files
echo "🛠 Installing homebrew apps"
cat $DIR/Brewfile | xargs brew install

echo "🛠 Installing homebrew-cask apps"
cat $DIR/Caskfile | xargs brew cask install

echo "🛠 Installing yarn apps"
cat $DIR/Yarnfile | xargs yarn global add

echo "🛠 Installing gem apps"
cat $DIR/Gemfile | xargs sudo gem install

echo "🛠  Installing MacAppStore apps"
grep "^[^#]" $DIR/Masfile | xargs mas install
