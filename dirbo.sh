#!/usr/bin/bash

link=$1
word=$2

result=$(curl -is $link/$word | egrep 'HTTP/' | cut -d ' ' -f2)

if [ $result == 404 ]; then
	echo '[-] Not Found: '$word
else
	echo '[+] Found: 'http://$link/$word \($result\)
fi
