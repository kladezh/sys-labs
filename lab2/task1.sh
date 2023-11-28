#!/bin/bash

# если не переданно аргументов
if [ $# -eq 0 ]; then
  # попытка прочитать число из файла .myevents.conf
  n=$(cat ./.myevents.conf )
  # число n будет из файла (если есть), или 7 (по умолчанию)
  n=${n:-7}
  # вывод n записей
  tail -n $n ./.myevents
else
  # запись строки в файл
  echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> ./.myevents
fi
