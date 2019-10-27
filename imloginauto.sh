#!/bin/bash

source utils.sh

login() {
  if test -z "$1"
  then
    auth="$(cat auth)"
  else
    auth="$(cat $1)"
  fi  

  echo -e "${auth}" | ./imlogin.sh

  if test -z "$(cat pupilids)"
  then
    return 1
  else
    return 0
  fi
}

failed=0

for i in {1..5}; do
  if login; then
    failed=0
    echo -e "Succesful login. Continuing..."
    break
  else
    failed=1
    echo -e "Failed to login. Trying again..."
  fi
done

if test -z ${failed}; then
  echo -e "Failed to login after several attempts. Aborting..."
  # Notify user of failed attempts via email?
  exit
fi

echo -e "Fetching updates..."

./imnewsall.sh

echo -e "Logout..."

./imlogout.sh

echo -e "Done."
