set -gx LSCOLORS gxfxcxdxbxegedabagacad

set fish_greeting ""

set -l additional_path_items "$HOME/bin" "$HOME/.cargo/bin" "$HOME/.dotnet/tools"
for p in $additional_path_items
    if test -d $p; and not contains $i $PATH
    set PATH $p $PATH
    end
end

# GOPATH
set PATH (go env GOPATH)/bin $PATH

# Load work specific configuration if file exists
set -l work_config  ~/.config/fish/work.fish
if test -e $work_config
    source $work_config
end

# Setting up the SSH Agent
# https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end

set -gx GPG_TTY (tty)

