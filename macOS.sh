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
    echo "Adding /usr/local/bin/fish to /etc/shells"
    sudo echo "/usr/local/bin/fish" >> /etc/shells
else
    echo "fish already in /etc/shells, skipping."
fi

# set fish as default shell
chsh -s /usr/local/bin/fish

# Install rustup + rust tools through cargo instead of brew since brew will pull
# down its own version of Rust that isn't managed by rustup. That seems a little
# silly since I also want to have rust for dev stuff anyway. I could do this in
# setup.fish but decided to have these here first since I have fish aliases for
# exa
curl —proto ‘=https’ —tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
cargo install ripgrep exa
