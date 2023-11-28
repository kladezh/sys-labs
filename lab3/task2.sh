#!/bin/bash

# По пути каждого пути в PATH может хранится программа (в формате .exe)
# Нужно передать в этот скрипт название какой-нибудь программы (с указанием .exe или без, работает по разному)

# Разделение переменной PATH на массив
IFS=':' read -ra paths <<< "$PATH"

program=$1

exists=0

program_path=$(which "$program")

# Перебор всех элементов массива
for path in "${paths[@]}"; do
    # Проверка на существование каталога
    if [ "$path/$program" == "$program_path" ]; then
        exists=1
        break
    fi
done

if [ "$exists" -eq 1 ]; then
  echo "Программа $program существует по пути '$path'в перменной PATH"
else
  echo "Путь к программе $program не сущесвует в переменной PATH"
fi

