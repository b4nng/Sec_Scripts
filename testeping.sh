#!/bin/bash

if [ "$1" == "" ] 
then
	echo Insira primeiro o IP
	echo Exemplo: $0 10.0.0. 
else
	touch pingscan
	echo "Discovered Hosts:" >> pingscan
	for i in {1..254};do
		ping -c1 $1$i | grep "64 bytes" | cut -d " " -f4 | sed 's/://' >> pingscan &
	done
	cat pingscan
	rm pingscan	
fi
