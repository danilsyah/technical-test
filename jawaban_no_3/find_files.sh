#!/bin/bash

# Memastikan bahwa dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <file_extension>"
    exit 1
fi

# Mengambil parameter
directory=$1
extension=$2

# Memastikan bahwa direktori yang diberikan ada
if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist."
    exit 1
fi

# Menemukan file dengan ekstensi yang diberikan
find "$directory" -type f -name "*.$extension"
