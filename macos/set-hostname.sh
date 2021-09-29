#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <hostname>"
    exit
fi

sudo scutil --set HostName $1
