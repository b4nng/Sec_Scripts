#!/bin/bash

if [ "$1" == "" ] 
then
	echo Insira primeiro o IP
	echo Exemplo: $0 10.0.0. 
else
	touch pingscan

	for i in {1..254};do
		arping -c1 -W1 -i eth0 $1$i | grep "60 bytes" | cut -d " " -f4 | sed 's/://' >> pingscan &
	done
	cat pingscan
	echo -e "ARP PING Discovered Hosts:" $(wc -l pingscan)
	rm pingscan	
fi
