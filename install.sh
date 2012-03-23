#!/usr/bin/env bash
uname=`uname -s`

function link_file {
  source="${PWD}/$1"
  target="${HOME}/${1/_/.}"

  #if [ -e "${target}" ]; then
    #mv $target $target.bak
  #fi

  if [[ "$uname" = MINGW* || "$uname" = CYGWIN* ]]; then
    sourcestep=${source:2}
    source=${sourcestep//\//\\}
    targetstep=${target:2}
    target=${targetstep//\//\\}

    $COMSPEC \/c link.bat\ ${HOMEDRIVE}$source\ ${HOMEDRIVE}$target
    return
  else
    ln -sfv ${source} ${target}
  fi
}

if [ "$1" = "vim" ]; then
  for i in _vim*
  do
    link_file $1
  done
else
  for i in _*
  do
    link_file $i
  done
fi

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update
