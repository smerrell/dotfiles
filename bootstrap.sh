#! /usr/bin/env bash

# Bootstraps a machine with some required packange management tools
# Then defers to the Fish shell scripts

# determine OS
os=$(uname)

# Run OS boostrap script
if [[ "$os" -eq "Darwin" ]];
then
	./macOS.sh
fi

