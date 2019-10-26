#!/bin/bash

curl -X POST \
  'https://hub.infomentor.se/grouptimeline/grouptimeline/appData' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Length: 0' \
  -H 'Origin: https://hub.infomentor.se' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile -o output.txt

curl -X POST 'https://hub.infomentor.se/GroupTimeline/GroupTimeline/GetGroupTimelineEntries' \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json; charset=UTF-8' \
  -H 'Origin: https://hub.infomentor.se' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'cache-control: no-cache' \
  -d '{"page":1,"pageSize":50,"groupId":-1,"returnTimelineConfig":true}' \
  -b cookiefile -c cookiefile
