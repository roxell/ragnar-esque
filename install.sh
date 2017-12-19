#!/bin/bash

ROOTDIR=$(readlink -f $(dirname $0))

home_bin_dir=$HOME/bin
mkdir -p ${home_bin_dir}

cd ${home_bin_dir}
for file in $(cd ${ROOTDIR} && ls *kernel); do
    ln -sf ${ROOTDIR}/${file} ${file}
done

## vim: set sw=4 sts=4 et foldmethod=syntax : ##
