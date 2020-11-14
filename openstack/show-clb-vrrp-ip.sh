#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <vip>"
    exit
fi

vip=$1

source /root/keystonerc_admin
amphora_ids=$(openstack loadbalancer amphora list | grep " ${vip} " | awk '{print $2}')

echo $vip
for id in $(echo $amphora_ids)
do
    openstack loadbalancer amphora show $id | grep vrrp_ip
done
