#!/bin/bash

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

  ./imnews.sh > tmp
  replaceNewlines "$(cat tmp)" > news${id}.txt
  diff --changed-group-format='%<%>' --unchanged-group-format='' news${id}old.txt news${id}.txt > newsdiff
  cp newsdiff news${id}update.txt
  cp news${id}.txt news${id}old.txt

  ./imtimeline.sh > tmp
  replaceNewlines "$(cat tmp)" > timeline${id}.txt
  diff --changed-group-format='%<%>' --unchanged-group-format='' timeline${id}old.txt timeline${id}.txt > timelinediff
  cp timelinediff timeline${id}update.txt
  cp timeline${id}.txt timeline${id}old.txt

done

rm tmp
rm newsdiff
rm timelinediff
