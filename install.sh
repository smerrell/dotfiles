#!/usr/bin/env bash
uname=`uname -s`

function link_dotfile {
  source="${PWD}/$1"
  target="${HOME}/${1/_/.}"

  symlink_file $source $target
}

function symlink_file {
  source=$1
  target=$2

  # For Windows
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

function link_bin {
  if [ ! -d ${HOME}/bin ]; then
    echo 'Making ~/bin directory'
    mkdir -p ${HOME}/bin
  fi

  for binfile in bin/*
  do
    source="${PWD}/${binfile}"
    target="${HOME}/${binfile}"
    symlink_file $source $target
  done
}

for i in _*
do
  link_dotfile $i
done

link_bin

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update
