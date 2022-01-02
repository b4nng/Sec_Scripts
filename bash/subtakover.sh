#!/bin/bash

dominio=$1
arquivo=$2

for word in $(cat $arquivo); do
       host -t cname $word.$dominio | grep 'alias'
done
