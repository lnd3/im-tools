#!/bin/bash

newsfilename=$1

## get all pupil news
pupilids=$(cat pupilids)
for id in $pupilids; do
  ./imswitchpupil.sh ${id}
  ./imnews.sh > ${newsfilename}${id}.html
done
