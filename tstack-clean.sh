#!/bin/bash

# delete all VMs

nova delete tstack-venus tstack-monitor2 tstack-windows tstack-windows2

while true
do
	if ! nova list | grep -E 'tstack-venus|tstack-window|tstack-monitor' > /dev/null; then
		break
	fi
	sleep 3
done

# delete floating ips
for id in $(neutron floatingip-list | grep 10.10.2 | awk '{print $2}')
do
	neutron floatingip-disassociate ${id}
	neutron floatingip-delete ${id}
done

# delete tstack router
for router in $(neutron router-list | grep tstack_router | awk '{print $2}')
do
	neutron router-gateway-clear ${router}
	for p in $(neutron router-port-list ${router} | awk '{print $2}')
	do
		neutron router-interface-delete ${router} port=${p}
	done
	neutron router-delete ${router}
done

# delete subnet
for subnet in $(neutron subnet-list | grep -E 'HA subnet |tstack-internal-subnet|tstack-vxlan-subnet' | awk '{print $2}')
do
	for p in $(neutron port-list | grep ${subnet} | awk '{print $2}')
	do
		neutron port-delete ${p}
	done
	neutron subnet-delete ${subnet}
done

# delete network
for network in $(neutron net-list | grep -E 'HA network |tstack-internal-network|tstack-vxlan-network' | awk '{print $2}')
do
	neutron net-delete ${network}
done
