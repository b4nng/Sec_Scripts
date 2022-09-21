#!/usr/bin/bash

gobuster -t 50 dir --url='http://'$1'/' --wordlist=/usr/share/wordlists/dirb/common.txt -o tempFILE
_sed='s/\//http:\/\/'$1'\//g'
cat tempFILE | grep -v 403 | cut -d ' ' -f1 | sed $_sed
rm tempFILE
