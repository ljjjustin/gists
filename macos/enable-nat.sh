#!/bin/bash

sudo sysctl -w net.inet.ip.forwarding=1
sudo pfctl -evf /etc/pf.custom
sudo pfctl -sn
