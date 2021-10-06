#!/bin/bash

if [ "$1" == "" ] 
then
	echo Favor inserir o dominio como argumento
else
	file=tempHTML
	touch $file
	wget -O $file $1 -q
	for host in {$(cat $file | grep "href=" | cut -d "/" -f 3 | grep "$1" | sort -u | cut -d '"' -f 1 | cut -d "?" -f 1 | sort -u )}; do
		host $host | grep "has address" | sed 's/has address//'
	done
	rm $file
fi
