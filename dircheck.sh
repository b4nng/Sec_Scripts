#!/usr/bin/bash

word=$2
domain=$1

	echo "Testing $word..."
	resposta=$(curl -o /dev/null -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" -w "%{http_code}" $domain/$word/ 2> /dev/null)
	respostafile=$(curl -o /dev/null -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" -w "%{http_code}" $domain/$word 2> /dev/null)
	if [ "$respostafile" == "200" ]; then
	       echo "[+] File Found: http://$domain/$word"
	fi
	if [ "$resposta" == "200" ]; then
		echo "[+] Directory Found: http://$domain/$word/"
	fi

