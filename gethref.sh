#!/bin/bash

if [ "$1" == "" ] 
then
	echo Favor inserir o dominio como argumento
else
	file=tempHTML
	touch $file
	wget -O $file $1 -q
	echo -n '<===========[+] HREF links [+]===========>'
	cat tempHTML| sed 's/ /\n/g' | egrep 'href' | cut -d '"' -f2 | sort | uniq
	echo ''
	echo "<===========[+] SRC links [+]===========>"
	cat tempHTML| sed 's/ /\n/g' | egrep 'src' | cut -d '"' -f2 | sort | uniq
	rm $file
fi
