#!/usr/bin/env fish

if not test -d ~/.config
    mkdir ~/.config
else
    echo "~/.config exists, skipping"
end

for linkable in _*
    set linkdir (string replace -r "^_" "." $linkable)
    if not test -L "$HOME/$linkdir"
        ln -sv "$PWD/$linkable" "$HOME/$linkdir"
    else
        echo "$HOME/$linkdir already symlinked, skipping"
    end
end

git submodule init
git submodule update

