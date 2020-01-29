#!/usr/bin/env bash
email=$1
subject=$2
attachment=$3

a=$(cat ${attachment})
echo ${a}

  {
    echo "To: ${email}"
    echo "MIME-Version: 1.0"
    echo "Subject: ${subject}"
    echo -e "$(cat ${attachment})"
  } | /usr/sbin/ssmtp ${email}