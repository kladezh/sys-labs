#!/bin/bash

# Путь к этому скрипту
dir="$(dirname "$0")"

archive_dir="$dir/.deleted_files"

# Проверка наличия каталога с удаленными файлами
if [ ! -d "$archive_dir" ]; then
    echo "Каталог с удаленными файлами не существует."
    exit 1
fi

# Проверка переданных аргументов
if [ $# -eq 0 ]; then
    echo "Использование: $0 <часть_имени_или_дата>"
    exit 1
fi

search_term="$1"

# Поиск файлов в каталоге с удаленными файлами
found_files=()
while IFS= read -r -d $'\0' file; do
    found_files+=("$file")
done < <(find "$archive_dir" -type f -name "*$search_term*" -print0)

# Проверка наличия найденных файлов
if [ ${#found_files[@]} -eq 0 ]; then
    echo "Файлы с именем или датой, содержащими \"$search_term\", не найдены."
    exit 1
fi

# Вывод найденных файлов
echo "Найденные файлы:"
for ((i=0; i<${#found_files[@]}; i++)); do
    echo "$i: $(basename "${found_files[i]}")"
done

selected_file=""

if [ "${#found_files[@]}" -eq 1 ]; then
    selected_file="${found_files[0]}"
else
    # Запрос пользователя для выбора файла для восстановления
    read -p "Выберите номер файла для восстановления: " selected_index
    
    # Проверка наличия введенного номера
    if ! [[ "$selected_index" =~ ^[0-9]+$ ]] || [ "$selected_index" -lt 0 ] || [ "$selected_index" -ge ${#found_files[@]} ]; then
        echo "Введен некорректный номер файла."
        exit 1
    fi

    selected_file="${found_files[selected_index]}"
fi

# Восстановление файла
restore_file="$dir/$(echo "$(basename "$selected_file")" | sed 's/^[0-9]\{8\}_[0-9]\{6\}_//')"
mv "$selected_file" "$restore_file"

echo "Файл успешно восстановлен как \"$restore_file\"."
