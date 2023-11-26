read -p 'Enter the filename to read: 'filename
echo 'Nubmer of rows: '$(wc -l 2>/dev/null < $filename)
echo 'Number of words: ' $(wc 2>/dev/null -w < $filename)
