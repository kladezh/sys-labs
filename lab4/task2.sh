#!/bin/bash

# нужно запустить скрипт без аргументов и найти, в какой группе есть несколько пользователей, например:
# bash task2.sh
# adm:syslog,yamsh - в группе 'adm' 2 пользователя

# потом запустить скрипт с передачей ему какого-либо имени пользователя из этой группы
# bash task2.sh yamsh

# без аргументов - вывод всех групп
if [ $# -eq 0 ]; then
    echo -e "\nСписок всех групп:"
    getent group | cut -d: -f1,4 | sort

# с аргументом (именем пользователя) - вывод по заданию
else
    target_user="$1"

    # получаем список групп пользователя
    groups=$(id -nG "$target_user")
    users_in_groups=""

    for group in $groups; do
        users=$(getent group "$group" | cut -d: -f4)
        users_in_group=$(echo "$users" | awk -v target="$target_user" 'BEGIN { RS="," } { if ($1 != target) print $1 }')
        users_in_groups+="$users_in_group"
    done

    if [ -z "$users_in_groups" ]; then
        echo "Нет пользователей, входящие в хотя бы одну группу с пользователем $target_user..."
    else
        echo "Пользователи, входящие в хотя бы одну группу с пользователем $target_user:"
        echo "$users_in_groups"
    fi
fi

