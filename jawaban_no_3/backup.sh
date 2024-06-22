#!/bin/bash

# Fungsi untuk menampilkan cara penggunaan script ini
usage() {
    echo "Usage: $0 [source_directory] [destination_directory]"
    echo "Example: $0 /path/to/source /path/to/backup"
    exit 1
}

# Memastikan jumlah parameter input benar
if [ "$#" -ne 2 ]; then
    usage
fi

# Menentukan direktori sumber dan tujuan
SOURCE_DIR=$1
DEST_DIR=$2

# Memastikan direktori sumber ada
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Memastikan direktori tujuan ada, jika tidak ada maka dibuat
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Menentukan nama file backup dengan format nama_direktori_sumber_tanggal.tar.gz
BASE_NAME=$(basename "$SOURCE_DIR")
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${DEST_DIR}/${BASE_NAME}_backup_${DATE}.tar.gz"

# Membuat backup dan mengompresnya
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Mengecek apakah proses backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed"
    exit 1
fi
