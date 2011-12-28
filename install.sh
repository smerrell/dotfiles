#!/usr/bin/env bash
function link_file {
  source="${PWD}/$1"
  target="${HOME}/${i/_/.}"

  if [ -e "${target}" ]; then
    mv $target $target.bak
  fi

  ln -sfv ${source} ${target}
}

if [ "$1" = "vim" ]; then
  for i in _vim*
  do
    link_file $1
  done
else
  for i in _*
  do
      source="${PWD}/$i"
      target="${HOME}/${i/_/.}"
      ln -sfv ${source} ${target}
  done
fi

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update
