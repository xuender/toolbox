#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import sys
from chrome import ChromeDev

def ver():
    '修改版本'
    verfile = open('ver.txt', 'r')
    ver = int(verfile.read())
    ver += 1
    print 'update ver: %s' % ver
    verfile.close()
    verfile = open('ver.txt', 'w')
    verfile.write(str(ver))
    verfile.close()
    return ver

if __name__ == '__main__':
    print 'start...'
    b = False
    d = False
    for arg in sys.argv:
        if arg=='d':
            d = True
        if arg=='b':
            b = True
    dev = ChromeDev(debug = d, ver='0.1.%s' % ver())
    if b:
        dev.build()
    dev.run()
