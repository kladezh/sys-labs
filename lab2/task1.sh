#!/bin/bash

if [ $# -eq 0 ]; then
  n=$(cat ./.myevents.conf )
  n=${n:-7}
  tail -n $n ./.myevents
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> ./.myevents
fi
