#!/usr/bin/python

import socket, sys

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
if(len(sys.argv) != 3):
    print "Use com ./porttester.py IP PORTA"
    exit()
if s.connect_ex((sys.argv[1], int(sys.argv[2]))) == 0:
    print sys.argv[1],sys.argv[2],"[ABERTA]"
    s.close()
else:
    print "[FECHADO]"

