#!/usr/bin/python

import sys, socket

ip=sys.argv[1]
porta=int(sys.argv[2])
if(len(sys.argv)!=3):
    print "Example usage: ./script IP PORT"
    exit()
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print "Grabbing",ip,porta
s.connect((ip,porta))
print s.recv(1024)
s.close()
