#!/bin/bash

if [ ! $(which naabu) ]; then
	echo "Naabu not detected"
	sleep 1
	echo "Installing naabu..."
	apt update -yy
	apt install libpcap-dev -yy
	go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
fi

if [ $# -ne 1 ];then
	echo Usage:\t $0 subdomains.list
	exit 1
fi


SUBDOMAINS=$1
COMMON_PORTS_WEB="81,80,300,443,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,60443,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672"

naabu -l $SUBDOMAINS -p $COMMON_PORTS_WEB > naabu_commonweb.txt
cat naabu_commonweb.txt | httpx -random-agent -status-code -silent -retries 2 -no-color | cut -d ' ' -f1 | tee hosts_withports.txt

cat hosts_withports.txt | httpx -ss
chmod -R 777 ./output/
