#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <vm uuid or name>"
    exit
fi

vm=$1

wait_status() {
    local target=$1

    while true
    do
        status=$(nova show ${vm} | grep -w status | awk '{print $4}' | awk '{print tolower($0)}')

        if [ "${target}" = "${status}" ]; then
            break
        fi
        sleep 3
    done
}

nova stop ${vm}
wait_status shutoff

nova migrate ${vm}
wait_status verify_resize

nova resize-confirm ${vm}
wait_status shutoff

nova start ${vm}
