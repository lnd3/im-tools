#!/bin/bash

source utils.sh

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

removeFileIfExist tmp
removeFileIfExist newsdiff
removeFileIfExist timelinediff
