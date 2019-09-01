#!/usr/bin/env bash

vscodeInstance="code"
if [ "$1" == "--insiders" ]; then
  vscodeInstance="code-insiders"
  shift
fi

fullsync=false
if [ "$1" == "--full" ]; then
  fullsync=true
fi

# test code is installed
command -v $vscodeInstance >/dev/null 2>&1 || {
  echo >&2 "This script requires $vscodeInstance but it's not installed. Aborting."
  exit 1;
}

syncText=$($vscodeInstance --list-extensions | diff vscode-plugins.txt -)

# < install
install=$(echo "$syncText" | grep "^<")
# > uninstall
uninstall=$(echo "$syncText" | grep "^>")

if [ "$fullsync" = true ]; then
  # readarray -t extensions <<< "$uninstall"
  IFS=$'\n' read -rd '' -a extensions <<< "$uninstall"
  for extension in "${extensions[@]}"; do
    ext="${extension#"> "}"
    if [ ! -z "$ext" ]; then
      $vscodeInstance --uninstall-extension $ext
    fi
  done
fi

# readarray -t extensions <<< "$install"
IFS=$'\n' read -rd '' -a extensions <<< "$install"
for extension in "${extensions[@]}"; do
  ext="${extension#"< "}"
  if [ ! -z "$ext" ]; then
    $vscodeInstance --install-extension $ext
  fi
done
