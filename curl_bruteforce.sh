#!/usr/bin/bash

firstfile=$1
outfile=$2

url='10.254.16.70:8080'

echo 'Fuzzing...'
echo '' > $outfile
for line in $(cat $firstfile); do
	curl -X GET -H 'Host: '$url -H 'Origin: http://'$url -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0' --url 'http://'$url'/'$line -k -L -s >> $outfile &
done

less +F $outfile
rm $outfile
