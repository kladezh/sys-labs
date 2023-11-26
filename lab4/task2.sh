#!/bin/bash

if [ $# -eq 0 ]; then
    # Вывод всех пользователей
    echo "Список всех пользователей:"
    getent passwd | cut -d: -f1 | sort

    # Вывод всех групп
    echo -e "\nСписок всех групп:"
    getent group | cut -d: -f1 | sort
else
    target_user="$1"

    # Получаем список групп пользователя
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

