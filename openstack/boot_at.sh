#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <compute node>"
    exit
fi

host=$1

nova boot --flavor TSF-1 --image d5e7bbb9-00c4-4b3c-ab32-baff5ec0c2cc \
    --user-data userdata.txt --nic net-id=8bd9b058-d142-400f-9c22-3847178ad409 \
    --availability-zone nova:${host} test-${host}
