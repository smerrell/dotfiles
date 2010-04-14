#!/usr/bin/env bash
for i in _*
do 
    source="${PWD}/$i"
    target="${HOME}/${i/_/.}"
    if [ -e "${target}" ]; then
        echo "${target} already exists"       
    else
        ln -sfv ${source} ${target}
    fi

    if [ "$(basename $source)" == "_config" ]; then
        for y in ${source}/*
        do
          cfgdir="$(basename $y)"
          cfgdest="${HOME}/.config/${cfgdir}"
          if [[ -e "${cfgdest}" || -L "${cfgdest}" ]]; then
            echo ${cfgdest} already exists
          else
            ln -sfv ${PWD}/_config/${cfgdir} ${cfgdest}
          fi
        done
    fi
done
