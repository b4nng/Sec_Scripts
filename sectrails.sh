#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage $0 domain.com"
	exit 1
fi

API_KEY="fYmSKDmU4Gzy_7FzsOfaQKYBo_aTcN8U"
domain="$1"

curl -s "https://api.securitytrails.com/v1/history/$domain/dns/a" \
     -H "APIKEY: $API_KEY" \
     | jq -r '.records[].values[].ip' | sort -u | tee -a sectrails.sh-$domain.output
