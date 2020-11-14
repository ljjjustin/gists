#!/bin/bash

ceph osd tree > osd_tree.txt

for ((i=0; i < 30; i++))
do
    n=$((RANDOM%1000))
    pgnum=$(sed -ne "${n} p" pg-info.txt | awk '{print $1}')
    osds=$(ceph pg map $pgnum | awk '{print $NF}' | tr '[,]' ' ')
    grepstr="root|rack|host"
    for o in $(echo $osds)
    do
        grepstr="${grepstr}|osd.${o}"
    done
    grep -wE "${grepstr}" osd_tree.txt
done
