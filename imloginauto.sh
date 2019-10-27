#!/bin/bash

auth="$(cat $1)"

if test -z "$1"
then
  auth="$(cat auth)"
fi  

echo -e "${auth}" | ./imlogin.sh