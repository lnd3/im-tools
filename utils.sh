#!/bin/bash

removeFileIfExist() {
  if test -f "$1"; then
    rm "$1"
  fi
}

replaceNewlines() {
  newline='\n'
  newline2='\\n'
  br='<br>'

  string=$1
  string1=${string//${br}/${newline}}
  string2=${string1//${newline2}/${newline}}
  echo -e ${string2}
}

