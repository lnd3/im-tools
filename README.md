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

### Ideal use case
Put your credentials in 'auth', then call
```
$ ./imloginauto.sh
```
and you should get a bunch of files containing the new and timeline of late. There will also be 'update' files, containing the changes since last time this script was called.
### Individual scripts
If you want to make individual calls use any of the following commands
```
$ ./imlogin.sh myusername
Password: mypassword
$ ./imnewsall.sh
$ ./imlogout.sh
```
## Misc
For more info about infomentor, see https://www.infomentor.se/.
