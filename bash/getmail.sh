#!/bin/bash

if [ "$1" == "" ] 
then
	echo Favor inserir o dominio como argumento
else
	file=tempHTML
	touch $file
	wget -O $file $1 -q
	for host in $(cat $file | grep @ | sed -E 's/<[a-z:=\"]+>//g' | sed 's/\s//g'); do
		echo $host
	done
	rm $file
fi
