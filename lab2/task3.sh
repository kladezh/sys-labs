#!/bin/bash

# чтобы скрипт запускался автоматически при входе в систему, надо добавить его в файл '~/.bashrc':
# nano ~/.bashrc
# (внутри файла) bash /путь/к/лабе2/task3.sh
# source ~/.bashrc - вручную выполнить скрипт

# получение папки скрипта
dir="$(dirname "$0")"

if [ $# -eq 0 ]; then
  n=$(cat "$dir/.myevents.conf")
  n=${n:-7}
  tail -n $n "$dir/.myevents"
else
  if [ $1 = "-d" ]; then
    start_date=$2
    awk -v date="$start_date" '$1 >= date' "$dir/.myevents"
  else
    echo "$(date +'%Y-%m-%d %H:%M:%S') $*" >> "$dir/.myevents"
  fi
fi
