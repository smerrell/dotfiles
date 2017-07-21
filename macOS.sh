#!/usr/bin/env bash

echo "Bootstrapping macOS machine"
xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install fish

# set fish as a usable shell
