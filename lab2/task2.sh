#!/bin/bash

n=$(cat ./.myevents.conf)
n=${n:-7}

if [ $# -eq 0 ]; then
  tail -n $n ./.myevents
else
  if [ $1 = "-d" ]; then
    start_date=$2
    awk -v date="$start_date" '$1 >= date' ./.myevents | head -n $n
  else
    echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> ./.myevents
  fi
fi
