#!/usr/bin/env bash

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
# string3=${string2//}
# regexp to find date: grep "([1-2][0-9]|[3][0-1]|[1-9])\/([1][0-2]|[1-9])""
# find 12/16/09 etc: grep "^12\/1[6-8]\/09

  echo -e ${string2}
}

