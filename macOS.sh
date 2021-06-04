#!/usr/bin/env bash

echo "Bootstrapping macOS machine"
xcode-select --install 2&> /dev/null

# Check if we are on Apple Silicon
UNAME_MACHINE="$(uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
fi


which -s $HOMEBREW_PREFIX/bin/brew
if [[ $? != 0 ]]; then
    echo "Brew not installed. Installing."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Brew installed, running an update"
    $HOMEBREW_PREFIX/bin/brew update
fi

$HOMEBREW_PREFIX/bin/brew install fish
 
# set fish as a usable shell
if ! grep -q "fish" /etc/shells; then
    echo "Adding $HOMEBREW_PREFIX/bin/fish to /etc/shells"
    # Regular sudo echo wasn't working? This worked and I got it from here:
    # https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262
    sudo sh -c "echo \"$HOMEBREW_PREFIX/bin/fish\" >> /etc/shells"
else
    echo "fish already in /etc/shells, skipping."
fi
 
# set fish as default shell for current user
defaultShell=$(finger $USER | grep -o 'Shell:\s.*' | cut -f2 -d " ")
if [[ "$defaultShell" == "$HOMEBREW_PREFIX/bin/fish" ]]; then
    echo "Fish is already the default shell. Skipping."
else
    username=$(id -un)
    chsh -s $HOMEBREW_PREFIX/bin/fish $username
fi
 
# Install rustup + rust tools through cargo instead of brew since brew will pull
# down its own version of Rust that isn't managed by rustup. That seems a little
# silly since I also want to have rust for dev stuff anyway. I could do this in
# setup.fish but decided to have these here first since I have fish aliases for
# exa
curl —proto ‘=https’ —tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
cargo install ripgrep exa
