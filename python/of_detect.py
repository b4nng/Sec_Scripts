#!/usr/bin/python

import socket, sys

try:
    ip = sys.argv[1]
    port = sys.argv[2]
    user = sys.argv[3]

    buff = ["A"]
    plus = 100
    
    while len(buff) <= 25:
        buff.append("A"*plus)
        plus += 200

    for string in buff:
        print "Fuzzing FTP USER with "+len(string)+" string length"
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        s.send("USER "+user+"\r\n")
except:
    print "Erro de Execucao"
