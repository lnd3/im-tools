#!/usr/bin/env bash

source utils.sh

timestring=`date +%Y%m%d-%H%M%S`


removeFileIfExist update.txt

## get all pupil news
pupilids=$(cat pupilids)
for id in $pupilids; do
  cp news${id}old.txt news${id}old_backup.txt
  cp timeline${id}old.txt timeline${id}old_backup.txt

  ./imswitchpupil.sh ${id}

  ./imnews.sh > tmp
  replaceNewlines "$(cat tmp)" > news${id}.txt
  diff --changed-group-format='%>' --unchanged-group-format='' news${id}old.txt news${id}.txt > newsdiff
  cp newsdiff news${id}update.txt
  cp news${id}.txt news${id}old.txt

  ./imtimeline.sh > tmp
  replaceNewlines "$(cat tmp)" > timeline${id}.txt
  diff --changed-group-format='%>' --unchanged-group-format='' timeline${id}old.txt timeline${id}.txt > timelinediff
  cp timelinediff timeline${id}update.txt
  cp timeline${id}.txt timeline${id}old.txt

  if [ -s newsdiff ] || [ -s timelinediff ]
  then
    echo -e "\n" >> update-${timestring}.txt
    echo -e "****************************************" >> update-${timestring}.txt
    echo -e ${id} >> update-${timestring}.txt
    echo -e "****************************************" >> update-${timestring}.txt
    echo -e "\n" >> update-${timestring}.txt
    cat newsdiff >> update-${timestring}.txt
    cat timelinediff >> update-${timestring}.txt

    cat newsdiff >> update${id}-${timestring}.txt
    cat timelinediff >> update${id}-${timestring}.txt

	if [ -s update${id}-${timestring}.txt ]
	then
	  emails=$(cat emails)
	  {
	    echo "To: ${emails}"
	    echo "MIME-Version: 1.0"
	    echo "Subject: Infomentor pupil ${id}, update ${timestring}"
	    echo -e "$(cat update${id}-${timestring}.txt)"
	  } | /usr/sbin/ssmtp ${emails}

	  echo -e "Sent pupil ${id} update ${timestring}."
	fi

  fi
done

removeFileIfExist tmp
removeFileIfExist newsdiff
removeFileIfExist timelinediff

exit



if [ -s update-${timestring}.txt ] && [ -s emails ]
then
  emails=$(cat emails)
  {
    echo "To: ${emails}"
    echo "MIME-Version: 1.0"
    echo "Subject: Infomentor update ${timestring}"
    echo -e "$(cat update-${timestring}.txt)"
  } | /usr/sbin/ssmtp ${emails}

  echo -e "Sent update ${timestring}."
fi
