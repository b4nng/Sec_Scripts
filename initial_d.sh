#!/bin/bash

# This script is intended to stop being cone

apt update -yy

sleep 1

if [ ! "$(which go)" ]; then apt install golang -yy; fi

sleep 1

if [ ! "$(which feroxbuster)" ]; then apt install feroxbuster -yy; fi

sleep 1

if [ ! "$(ls /root/go/bin/httpx 2>/dev/null)" ]; then go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && rm /bin/httpx; ln -s /root/go/bin/httpx /bin/httpx && httpx -ss; fi

sleep 1
if [ ! "$(ls /leaky-paths+fuzz-bo0om-friendly.txt 2>/dev/null)" ]; then 
  wget https://raw.githubusercontent.com/ayoubfathi/leaky-paths/refs/heads/main/leaky-paths.txt -O /leaky-paths.txt ;
  cat /leaky-paths.txt /usr/share/wordlists/seclists/Fuzzing/fuzz-Bo0oM-friendly.txt|sort -u > /leaky-paths+fuzz-bo0om-friendly.txt ;
fi

if [ ! "$(ls /root/go/bin/subfinder 2>/dev/null)" ]; then go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest; fi

