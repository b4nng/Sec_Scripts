#!/usr/bin/python3

import crypt
import sys

if (len(sys.argv) != 3):
    print("\n--- Crypt password hash breaker ---")
    print(f"Usage: {sys.argv[0]} [Filename] [wordlist]")
    print("Password file should be on the format: user $type$salt$hash")
    print("--------------\n")
else:
    words = open(sys.argv[2], 'r').readlines()
    passes = open(sys.argv[1], 'r').readlines()
    for passw in passes:
        print("Testing for "+passw.split()[0]+"...")
        for word in words:
            divided_pass = passw.split()
            index_typesalt = divided_pass[1].rindex('$')
            encrypted = crypt.crypt(word.strip(),divided_pass[1][:index_typesalt]) 
            if(encrypted == divided_pass[1]):
                print(f"[+] Password for {divided_pass[0]} : {word}")

