find ~ -type f -name "*.$1" -mtime $2 -exec basename {} . \;
