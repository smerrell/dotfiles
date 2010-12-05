#!/usr/bin/env bash

for i in _*
do 
    source="${PWD}/$i"
    target="${HOME}/${i/_/.}"
    ln -sfv ${source} ${target}
done
