#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "$0 <app dir>"
    exit
fi

app_dir=$1

xattr -cr ${app_dir}
sudo codesign --force --deep --sign - ${app_dir}
