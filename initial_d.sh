#!/bin/bash

# This script is intended to stop being cone

apt update -yy

sleep 1

if [ ! "$(which go)" ]; then apt install golang -yy; fi

sleep 1

if [ ! "$(which feroxbuster)" ]; then apt install feroxbuster -yy; fi

sleep 1

if [ ! "$(ls /root/go/bin/httpx 2>/dev/null)" ]; then go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest; fi
