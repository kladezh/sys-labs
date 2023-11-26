#!/bin/bash

if [ $# -eq 0 ]; then
  n=$(cat ./.myevents.conf)
  n=${n:-7}
  tail -n $n ./.myevents
else
  if [ $1 = "-d" ]; then
    start_date=$2
    awk -v date="$start_date" '$1 >= date' ./.myevents
  else
    echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> ./.myevents
  fi
fi
