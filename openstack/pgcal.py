# !/usr/bin/env python

import math
import sys

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print "usage: %s <osd amount>" % sys.argv[0]
    osd_num = int(sys.argv[1])
    power = int(math.log(osd_num * 100, 2)+0.99)
    total_pgs = 2**power

    print "images pool: ", total_pgs/16
    print "vms pool: ", total_pgs/2
    print "volumes pool: ", total_pgs/2

