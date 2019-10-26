# im-tools
An alternative infomentor interface.

## What?
im-tools is a set of bash scripts that interfaces with the infomentor system api.

## Why?
The primary objective is to enable and make available a frictionless experience when accessing your kid's news feed.
The secondary objective is to make available an easy-to-use alternative user interface to the infomentor api - contrary to what the official infomentor app achieves in terms of usability.

## How?
This tool suite lets you perform login, logout, pupil switching and news feed fetching.

## Usage
Using a unix-like environment the scripts can be called with credentials or pupilids, otherwise follow the prompt instructions. 
The scripts product several files in the working directory containing temporary information, for example the pupil id's which are used when selecting a current pupil for subsequent calls to the infomentor api's.

Typical use case:
```
$ ./imlogin.sh myusername
Password: mypassword  
$ ./imnewsall.sh
```

## Misc
For more info about infomentor, see https://www.infomentor.se/.
