#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage $0 raw_file"
	exit 1
fi

raw_file=$1

grep -Eo "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}" $raw_file | sort -u
