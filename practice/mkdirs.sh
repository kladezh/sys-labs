#!/bin/bash

BASEDIR=$1
FILE=$2

while read LINE
        do
        echo "$LINE"
        mkdir "${BASEDIR}$LINE"
done < $FILE

