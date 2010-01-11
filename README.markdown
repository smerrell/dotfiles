## Files
.screenrc 
    My Screen configurations
.vimrc 
    My Vim configurations
.gitconfig
    My git configuration
.bashrc
    My bash configuration

## Instructions
### Creating source files
Any file which matches the shell glob `_*` will be linked into `$HOME` as a symlink with the first `_`
replaced with a `.`

For example:

    _bashrc

becomes

    ${HOME}/.bashrc

### Installing source files
It's as simple as running:

    ./install.sh

From this top-level directory.

## Requirements
* bash
