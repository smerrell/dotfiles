set -gx LSCOLORS gxfxcxdxbxegedabagacad

set fish_greeting ""

echo "Adding SSH keys"
eval "ssh-agent -s" > /dev/null
ssh add -A

set -l additional_path_items "$HOME/bin" "$HOME/.cargo/bin"
for p in $additional_path_items
    if test -d $p; and not contains $i $PATH
	set PATH $p $PATH
    end
end

