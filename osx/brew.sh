# Install brew if it isn't installed already

if ! type brew 2>/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

node_packages=(
  bash-completion # __git_ps1
  git
  macvim
  tmux
  reattach-to-user-namespace # tmux copy/paste
  ack
  node
)

for package in ${node_packages[@]};
do
  brew install $package
done
