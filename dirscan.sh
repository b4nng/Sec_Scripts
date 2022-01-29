#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]; then
	echo Usage methods:
	echo ./dirscan.sh domain wordlist == Directory scan
	echo ./dirscan.sh domain wordlist extension == File scan
	exit
fi
domain=$1
arquivo=$2


if [ "$3" != "" ]; then
	extension=$3
	for word in $(cat $arquivo); do 
		resposta=$(curl -o /dev/null -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" -w "%{http_code}" $domain/$word.$extension)
		if [ "$resposta" == "200" ]; then
			echo "File $extension Found: http://$domain/$word.$extension"
		fi
	done
else
	for word in $(cat $arquivo); do 
		resposta=$(curl -o /dev/null -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" -w "%{http_code}" $domain/$word/)
		respostafile=$(curl -o /dev/null -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" -w "%{http_code}" $domain/$word)
		if [ "$respostafile" == "200" ]; then
		       echo "File Found: http://$domain/$word"	
		fi
		if [ "$resposta" == "200" ]; then
			echo "Directory Found: http://$domain/$word/"
		fi
	done
fi



