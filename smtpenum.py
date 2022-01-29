#!/usr/bin/python

import sys, socket, re



if len(sys.argv) != 3:
    print "Usage: python smtpenum.py IP listfile"
else:
    file = open(sys.argv[2])
    for linha in file.readlines():
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((sys.argv[1], 25))
        resp = s.recv(1024)
        s.send("VRFY "+linha)
        resp = s.recv(1024)
        if re.search("252", resp):
            print "Found: "+resp.strip('252 2.0.0')
    
    
