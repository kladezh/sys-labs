#!/bin/bash

# попытка прочитать число из файла .myevents.conf
n=$(cat ./.myevents.conf)
# число n будет из файла (если есть), или 7 (по умолчанию)
n=${n:-7}

# если не переданно аргументов
if [ $# -eq 0 ]; then
  # вывод n записей
  tail -n $n ./.myevents
else
  # если переданна дата -d
  if [ $1 = "-d" ]; then
    # вывод n записей, начиная с даты
    start_date=$2
    awk -v date="$start_date" '$1 >= date' ./.myevents | head -n $n
  else
    # запись строки в файл
    echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> ./.myevents
  fi
fi
