#!/bin/bash

if [ "$1" -eq 1 ]; then
    umask 027 # поставить rw-r----
    echo "Маска 027 установлена."
else
    umask 022 # поставить стандартную
    echo "Маска 022 установлена."
fi