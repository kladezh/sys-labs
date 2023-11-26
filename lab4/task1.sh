#!/bin/bash

# Путь к файлу /etc/passwd
passwd_file="/etc/passwd"

# Чтение файла /etc/passwd и вывод списка пользователей и их оболочек
while IFS=: read -r username password uid gid info home shell; do
    echo "Пользователь: $username"
    echo "Оболочка: $shell"
    echo "-------------------------"
done < "$passwd_file"

