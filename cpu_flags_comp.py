#!/usr/bin/env python

import sys

def compare_cpu_flags(cpu1, cpu2):

    with open(cpu1, "r") as f:
        cpu1_flags = f.read()
    with open(cpu2, "r") as f:
        cpu2_flags = f.read()

    cpu1_flag_set = set(cpu1_flags.strip().split())
    cpu2_flag_set = set(cpu2_flags.strip().split())

    if cpu1_flag_set == cpu2_flag_set:
        print "live migration is OK"
    elif cpu1_flag_set.issubset(cpu2_flag_set):
        print "live migration from cpu1 -> cpu2 is OK"
    elif cpu2_flag_set.issubset(cpu1_flag_set):
        print "live migration from cpu2 -> cpu1 is OK"
    else:
        print "live migration is NOT OK"

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print "usage: %s cpu1_flags cpu2_flags" % sys.argv[0]
        sys.exit()

    compare_cpu_flags(sys.argv[1], sys.argv[2])
