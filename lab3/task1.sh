#!/bin/bash

# Вывести все пути из переменной PATH
# echo $PATH | tr ':' '\n'

# Добавить неверный путь в PATH
# export PATH=$PATH:~/wrong/path

# Разделение переменной PATH на массив
IFS=':' read -ra paths <<< "$PATH"

# Флаг, указывающий на наличие ошибок
error_flag=0

# Перебор всех элементов массива
for path in "${paths[@]}"; do
    # Проверка на существование каталога
    if [ ! -d "$path" ]; then
        echo "Ошибка: Каталог '$path' в переменной PATH не существует."
        error_flag=1
    fi
done

# Проверка наличия ошибок
if [ "$error_flag" -eq 0 ]; then
    echo "Проверка завершена: все пути в переменной PATH корректны."
else
    echo "Проверка завершена: обнаружены ошибки в переменной PATH."
fi

