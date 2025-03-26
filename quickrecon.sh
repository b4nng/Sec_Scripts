#!/bin/bash

if [ "$1" == "update" ];then
	apt update -yy
	feroxbuster --update
	exit 0
fi	

DOMAIN=$1
LINE="## "
CODE_BLOCK='```'

if [ $# -ne 1 ]; then
	echo "Usage $0 domain"
	exit 1
fi

echo "---"
echo "Target: \"[[$DOMAIN]]\""
echo "Finding: "
echo "Criado-em: "$(date -I)
echo "---"

if [ ! $(which bypass-403.sh) ]; then
	echo Installing bypass-403...
	wget -q https://raw.githubusercontent.com/iamj0ker/bypass-403/refs/heads/main/bypass-403.sh
	sleep 2
	chmod +x bypass-403.sh
	sudo mv bypass-403.sh /bin/bypass-403.sh
fi

if [ ! $(which jq) ]; then
	echo Installing jq...
	apt update -yy
	apt install jq -yy
fi


echo "$LINE Host: " && host $DOMAIN | grep 'has address' |cut -d ' ' -f4
sleep 1

echo $LINE"SPF and DMARC"
sleep 1
echo $CODE_BLOCK
dig -t txt $DOMAIN
echo $CODE_BLOCK

echo $LINE'DMARC'
sleep 1
echo $CODE_BLOCK
dig -t txt _dmarc.$DOMAIN
echo $CODE_BLOCK

MAINDOMAIN=$(echo -n $DOMAIN |sed 's/^\w\+\.//g' )
echo $LINE"DMARC for root domain at $MAINDOMAIN"
sleep 1
echo $CODE_BLOCK
dig +short -t txt _dmarc.$MAINDOMAIN
echo $CODE_BLOCK

echo $LINE"Checking WAF:"
sleep 1
echo $CODE_BLOCK
wafw00f https://$DOMAIN | grep -F '[+]'
echo $CODE_BLOCK

echo $LINE"Getting Screenshot"
sleep 1
echo $CODE_BLOCK
httpx -u http://$DOMAIN -ss 
httpx -u https://$DOMAIN -ss 
echo $CODE_BLOCK

if [ $(ls $PWD/output/screenshot/$DOMAIN/*.png 2>/dev/null) ]; then
	echo $LINE"Saved at"
	echo $CODE_BLOCK
	$(ls $PWD/output/screenshot/$DOMAIN/*)
	echo $CODE_BLOCK
	echo "![["$(ls $PWD/output/screenshot/$DOMAIN/*.png|xargs -n1 basename)"]]"
fi

echo $LINE"Running leaky-paths.txt ..."
WORDLIST="/leaky-paths+fuzz-bo0om-friendly.txt"
sleep 1

echo $CODE_BLOCK
FEROX_OUTPUTFILE="$(date -I)"_"$DOMAIN.feroxbuster"
feroxbuster -q --auto-tune --no-state -n -C 404 -u "https://$DOMAIN" -o "HTTPS_"$FEROX_OUTPUTFILE -w $WORDLIST --random-agent -k

feroxbuster -q --auto-tune --no-state -n -C 404 -u "http://$DOMAIN" -o "HTTP_"$FEROX_OUTPUTFILE -w $WORDLIST --random-agent
echo $CODE_BLOCK

FOUND_403=$(cat HTTPS_$FEROX_OUTPUTFILE HTTP_$FEROX_OUTPUTFILE |grep 403\  |grep -Ev "\/\$" |tr -s ' '|cut -d ' ' -f6 | tail -n1 | sed "s/https?:\/\/$DOMAIN\///g")

if [ -n "$FOUND_403" ];then
	echo $LINE"Running bypass-403 on $FOUND_403"
	echo $CODE_BLOCK
	bypass-403.sh https://$DOMAIN $FOUND_403 | grep -E "200|\$"
	bypass-403.sh http://$DOMAIN $FOUND_403 | grep -E "200|\$"
	echo $CODE_BLOCK
fi
