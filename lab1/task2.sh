# Прочитать имя файла из комадной строки
read -p 'Enter the filename to read: 'filename

# Вывод числа строк из файла
echo 'Nubmer of rows: '$(wc -l 2>/dev/null < $filename)

# Вывод числа слов из файла
echo 'Number of words: ' $(wc 2>/dev/null -w < $filename)

# 2>/dev/null - подавление вывода ошибок (перенаправление вывода ошибок в нулевое устройство)