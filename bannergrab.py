#!/usr/bin/python

import sys, socket

ip=sys.argv[1]
porta=int(sys.argv[2])
if(len(sys.argv)!=3):
    print("Example usage: ./script IP PORT")
    exit()
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("Trying",ip,porta)
    s.connect((ip,porta))
    print(s.recv(1024).decode('utf-8'))
    s.close()
except ConnectionRefusedError:
    print(f"[-] Refused on {porta}")
    pass
