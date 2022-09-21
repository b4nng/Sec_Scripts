#!/bin/bash

iplist=$1

for ip in $(cat $iplist);do
	echo $ip
	wget https://www.shodan.io/host/$ip -O shodano -q;
	cat shodano | grep 'Ports open' | cut -d '"' -f4;
	echo '';
done	
rm shodano
