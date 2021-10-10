#!/usr/bin/python

import socket, sys

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
ip = sys.argv[1]
print ip
s.connect((ip, 21))
r = s.recv(1024)
print r

s.send("USER anonymous\r\n")
r = s.recv(1024)
print r

s.send("PASS anonymous\r\n")
r = s.recv(1024)
print r
