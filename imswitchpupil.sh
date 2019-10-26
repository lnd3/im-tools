#!/bin/bash

pupilid=$1

if test -z "$pupilid" 
then
  read -p "Pupilid: " pupilid
fi 

curl -X GET 'https://hub.infomentor.se/Account/PupilSwitcher/SwitchPupil/'$pupilid \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: gzip, deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile
