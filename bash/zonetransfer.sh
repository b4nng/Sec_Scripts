#!/bin/bash

for dominio in $(host -t NS $1 | cut -d " " -f4 | sed 's/\.$//'); do
	host -l $dominio | egrep -v 'FAIL|failed';
done
