#!/bin/bash

#vars
timestamp=$(date +%Y%m%d_%H%M%S)

if [ -z "$1" ]; then
    echo " Please provide a directory!"
    exit 1
fi

directory=$1

if [ -d "$directory" ]; then
    echo "Archiving $directory"
    tar -cvzf "$directory"_"$timestamp".tar.gz "$directory"
else
    echo "Error: "$directory" is not valid directory"
    exit 1
fi

