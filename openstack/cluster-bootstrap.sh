#!/bin/bash

# vm flavors
ensure_flavor() {
    local name=$1
    local vcpu=$2
    local mems=$3
    local disk=$4

    if ! nova flavor-list | grep -q -w " $name "; then
        nova flavor-create --is-public true $name auto $mems $disk $vcpu
    fi
}

ensure_flavor TMP-INST 4 8192 200
ensure_flavor TMP-GLOBAL 16 32768 200
ensure_flavor TMP-BUSS 4 4096 100

# vm network
ensure_network() {
    local net=$1
    local subnet="$2"

    if ! neutron net-list | grep -q -w " $net "; then
        neutron net-create $net
    fi

    if ! neutron subnet-list | grep -q -w " $subnet "; then
        neutron subnet-create --name $subnet $net 192.168.123.0/24
    fi
}

netname=tmp-net
subnet="${netname}-sub1"
ensure_network $netname $subnet

# router
ensure_router() {
    local router=$1

    if ! neutron router-list | grep -q -w " $router "; then
        neutron router-create $router
        neutron router-gateway-set $router tstack-floating-ips
        neutron router-interface-add $router $subnet
    fi
}
ensure_router tmp-router1

# installer
nova boot --flavor TMP-INST --image d5e7bbb9-00c4-4b3c-ab32-baff5ec0c2cc \
    --user-data userdata.txt --nic net-name=$netname \
    tmp-installer

# global cluster
nova boot --flavor TMP-GLOBAL --image d5e7bbb9-00c4-4b3c-ab32-baff5ec0c2cc \
    --user-data userdata.txt --nic net-name=$netname \
    tmp-global

# business cluster
for i in $(seq 1 3)
do
    nova boot --flavor TMP-BUSS --image d5e7bbb9-00c4-4b3c-ab32-baff5ec0c2cc \
        --user-data userdata.txt --nic net-name=$netname \
        tmp-buss${i}
done
