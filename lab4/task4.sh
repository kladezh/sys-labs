#!/bin/bash

# chmod +x /file - сделать file исполняемым
# chmod u+s /file - установить биты SUID
# chmod g+s /file - установить биты SGID

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

