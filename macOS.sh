#!/usr/bin/env bash

echo "Bootstrapping macOS machine"
xcode-select --install 2&> /dev/null

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install fish

# set fish as a usable shell
sudo echo "/usr/local/bin/fish" >> /etc/shells

# set fish as default shell
chsh -s /usr/local/bin/fish

