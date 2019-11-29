#!/bin/bash

SRCBR=br-tun
PPORT=patch-int
TAP=tap-${SRCBR}

OLD_PS1="$PS1"

cleanup() {
	ovs-vsctl clear bridge ${SRCBR} mirrors
	ovs-vsctl del-port ${SRCBR} $TAP
	ip link del dev $TAP
	export PS1="$OLD_PS1"
}

trap "cleanup" EXIT

ip link add name $TAP type dummy
ip link set dev $TAP up
ovs-vsctl add-port ${SRCBR} $TAP

ovs-vsctl -- --id=@dst get Port $TAP \
          -- --id=@src get Port ${PPORT} \
          -- --id=@m create Mirror name=$TAP select_dst_port=@src output_port=@dst \
          -- set Bridge ${SRCBR} mirrors=@m

ovs-vsctl list mirror

echo "tcpdump -pni $TAP"

export PS1="tcpdump > " && bash
