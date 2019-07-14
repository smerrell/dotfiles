#!/usr/bin/env bash

echo "Bootstrapping macOS machine"
xcode-select --install 2&> /dev/null

which -s brew
if [[ $? != 0 ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Brew installed, running an update"
    brew update
fi

brew install fish

# set fish as a usable shell
if ! grep -q "fish" /etc/shells; then
    sudo echo "/usr/local/bin/fish" >> /etc/shells
else
    echo "fish already in /etc/shells, skipping."
fi

# set fish as default shell
chsh -s /usr/local/bin/fish

