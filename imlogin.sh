#!/usr/bin/env bash

source utils.sh

## clean up
removeFileIfExist cookiefile
removeFileIfExist location
removeFileIfExist location2
removeFileIfExist oauth_token
removeFileIfExist pupilids
removeFileIfExist output.txt

##
username=$1
password=$2

if test -z "$username"
then
  read -p "Username: " username
fi

if test -z "$password"
then
  read -s -p "Password: " password
fi

## Fetch initial redirect first
curl -X GET 'https://hub.infomentor.se' -b cookiefile -c cookiefile -i | grep -oP "(?<=(Location: )).*" \
  > location
location="https://hub.infomentor.se"$(cat location)
echo "********************************************"
echo " > Extracted location: "$location
echo "********************************************"

## Follow initial redirect
curl -X GET $location -b cookiefile -c cookiefile -i \
  | grep -oP "(?<=(oauth_token\" value=\"))[\w+=/]+" > oauth_token

oauth_token=$(cat oauth_token)
echo "********************************************"
echo " > Extracted oauth token: "$oauth_token
echo "********************************************"

## Build auth structure
jsonblob=$(cat data.json)

jsonblob1=${jsonblob/username/$username}
jsonblob2=${jsonblob1/password/$password}

## Initial login page - set the cookies [ASP.NET_SessionId, BIGipServerinfomentor]
curl -X POST 'https://infomentor.se/swedish/production/mentor/' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://hub.infomentor.se' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/Authentication/Authentication/Login?ReturnUrl=%2F' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -d oauth_token=$oauth_token \
  -b cookiefile -c cookiefile -o output.txt

######################################
## Send credentials - sets the cookies [.ASPXAUTH, NotandaUppl]
curl -X POST 'https://infomentor.se/swedish/production/mentor/' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://infomentor.se' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  --data-raw $jsonblob2 \
  -b cookiefile -c cookiefile -o output.txt

## Enable pin page - sets the cookies [984527]
curl -X GET 'https://infomentor.se/Swedish/Production/mentor/Oryggi/PinLogin/EnablePin.aspx' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://infomentor.se/swedish/production/mentor/' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile -o output.txt

######################################
## Send dont activate pin
curl -X POST 'https://infomentor.se/Swedish/Production/mentor/Oryggi/PinLogin/EnablePin.aspx' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://infomentor.se' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://infomentor.se/Swedish/Production/mentor/Oryggi/PinLogin/EnablePin.aspx' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -d '__EVENTTARGET=aDontActivatePin&__EVENTARGUMENT=&__VIEWSTATE=%2FwEPDwULLTExNjgzNDAwMjdkZEPHrLmSUp3IKh%2FYk4WyEHsBQdMx&__VIEWSTATEGENERATOR=7189AD5F&__EVENTVALIDATION=%2FwEdAANT4hIcRyCqQMJVzIysT0grY9gRTC512bYsbnJ8gQeUrlnllTXttyQbAlgyFMdw9va%2BKdVQbZxLkS3XlIJc4f5qeOcV0g%3D%3D' \
  -b cookiefile -c cookiefile -o output.txt

## login
curl -X GET 'https://hub.infomentor.se/authentication/authentication/login?apitype=im1&forceOAuth=true' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://infomentor.se/Swedish/Production/mentor/Oryggi/PinLogin/EnablePin.aspx' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile -i -o output.txt

## mentor - redirecting to login page so auth was unsuccessful previously
curl -X POST 'https://infomentor.se/swedish/production/mentor/' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://hub.infomentor.se' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/authentication/authentication/login?apitype=im1&forceOAuth=true' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -d oauth_token=$oauth_token \
  -b cookiefile -c cookiefile -s -i \
  | grep -oP "(?<=(Location: )).*" \
  > location2

location2=$(cat location2)
echo "********************************************"
echo " > Extracted redirect location: "$location2
echo "********************************************"

if test -z "$location2" 
then
      echo " > Failed to extract location, exiting..."
      exit
fi

## login callback - using the 'location' in the previous response
curl -X GET $location2 \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/authentication/authentication/login?apitype=im1&forceOAuth=true' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile -o output.txt

## get pupil links so we can extract pupil id's
curl -X GET \
  https://hub.infomentor.se/ \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
  -H 'Accept-Encoding: gzip, deflate, br' \
  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://hub.infomentor.se/authentication/authentication/login?apitype=im1&forceOAuth=true' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36' \
  -H 'cache-control: no-cache' \
  -b cookiefile -c cookiefile \
  | gunzip - \
  | grep -oP "(?<=(/Account/PupilSwitcher/SwitchPupil/))[0-9]*" \
  | sort \
  | uniq > pupilids
