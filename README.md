# im-tools
An alternative infomentor interface.

## Why?
The primary objective is to enable and make available a frictionless experience when accessing your kid's news feed.
The secondary objective is to make available an easy-to-use alternative interface to the infomentor api - contrary to what the official infomentor app achieves in terms of usability.

## What is it?
im-tools is a set of bash scripts that interfaces with the infomentor system api.

## How does it work?
The bash scripts uses a program called 'curl' that can make calls to the infomentor servers. 
During login, the scripts make a sequence of back-and-forth calls and responses to finally recieve a certain link (a login callback), which can be used only once. 
When called, the login callback returns a certain cookie called 'imhome', which, in combination with the session cookie, allows subsequent calls to be considered as valid user calls.

Auth details are sent as hidden post data. No password hashing, no RSA, just https. Apparently trusting certificate providers is enough security for infomentor.

## Usage
Using a unix-like environment the scripts can be called with credentials or pupilids, otherwise follow the prompt instructions. 
The scripts product several files in the working directory containing temporary information, for example the pupil id's which are used when selecting a current pupil for subsequent calls to the infomentor api's.

### Ideal use case
Put your credentials in 'auth', then call
```
$ ./imloginauto.sh
```
and you should get a bunch of files containing the 'news' and 'timeline' data. There will also be some 'update' files, containing the changes since last time this script was called.
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
