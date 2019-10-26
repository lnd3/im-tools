#!/bin/bash

filenameprefix=$1

replaceNewlines() {
  newline='\n'
  newline2='\\n'
  br='<br>'

  string=$1
  string1=${string//${br}/${newline}}
  string2=${string1//${newline2}/${newline}}
  echo -e ${string2}
}

## get all pupil news
pupilids=$(cat pupilids)
for id in $pupilids; do
  ./imswitchpupil.sh ${id}

  ./imnews.sh > tmp1
  ./imtimeline.sh > tmp2

  file1=${filenameprefix}news${id}.txt
  file2=${filenameprefix}timeline${id}.txt

  replaceNewlines "$(cat tmp1)" > ${file1}
  replaceNewlines "$(cat tmp2)" > ${file2}

done
