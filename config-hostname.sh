#!/bin/bash

# get ip address
ip=$(ip a show dev bond1 | grep -w inet | awk '{print $2}' | cut -d '/' -f1)

# get hostname from hosts files
hostname=$(grep "${ip}" /etc/hosts | awk '{print $2}')

# modify hostname
hostnamectl set-hostname ${hostname}
