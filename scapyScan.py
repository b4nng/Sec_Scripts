#!/usr/bin/python3

import sys,os
from scapy.all import *

conf.verb = 0
try:
    if (len(sys.argv) < 3):
        print("Usage", sys.argv[0],"IP port")
        exit()
    else:
        ip = IP(dst=sys.argv[1])
        port = int(sys.argv[2])
        port = TCP(dport=port)

        packet = ip/port/"RandomData"
        responses, noresponses = sr(packet)
        for response in responses:
            if(response[1][TCP].flags == "SA"):
                print ("PORTA %d ABERTA" %response[1][TCP].sport)
except:
    print ("Internal Error")
