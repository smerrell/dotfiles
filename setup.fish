#!/usr/bin/env fish

if not test -d ~/.config
    mkdir ~/.config
else
    echo "~/.config exists, skipping"
end

# symlinks into $HOME
for linkable in _*
    set linkdir (string replace -r "^_" "." $linkable)
    if not test -L "$HOME/$linkdir"
        ln -sv "$PWD/$linkable" "$HOME/$linkdir"
    else
        echo "$HOME/$linkdir already symlinked, skipping"
    end
end

# symlinks into $HOME/.config
pushd config
for dir in *
    # Not sure how to avoid this since it looks like fish creates the
    # $HOME/config/fish folder once this script is run. Once that is
    # done, symlinking ends up going to $HOME/config/fish/fish...
    if string match "fish" $dir
        pushd $dir
        for file in *
            ln -sv "$PWD/$file" "$HOME/.config/fish/$file"
        end
        popd
    else if not test -L "$HOME/.config/$dir"
        ln -sv "$PWD/$dir" "$HOME/.config/"
    else
        echo "$HOME/.config/$dir already symlinked, skipping"
    end
end
popd

git submodule init
git submodule update

