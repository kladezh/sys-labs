#!/bin/bash

# нужно предварительно сделать, например в этой лабе, какой-то скрипт испольняемым и установить ему SUID и SGID:
# chmod +x task1.sh - сделать файл исполняемым
# chmod u+s task1.sh - установить биты SUID
# chmod g+s task1.sh - установить биты SGID
# (чтобы убрать эти установки нужно написать '-' вместо '+')

# потом запустить этот скрипт и передать ему имя пользователя

if [ -z "$1" ]; then
    echo "Использование: $0 <имя_пользователя>"
    exit 1
fi

target_user="$1"
home_directory=$(getent passwd "$target_user" | cut -d: -f6)

if [ -z "$home_directory" ]; then
    echo "Пользователь не найден или не имеет домашнего каталога."
    exit 1
fi

echo "Поиск файлов с установленными SUID и SGID в домашнем каталоге пользователя $target_user:"

find "$home_directory" -type f -executable \( -perm -4000 -o -perm -2000 \)  -exec ls -l {} \;

