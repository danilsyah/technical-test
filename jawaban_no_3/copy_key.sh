#!/bin/bash

# Fungsi untuk menampilkan cara penggunaan script ini
usage() {
    echo "Usage: $0 [public_key_file] [username] [server_ip]"
    echo "Example: $0 ~/.ssh/id_rsa.pub user 192.168.1.1"
    exit 1
}

# Memastikan jumlah parameter input benar
if [ "$#" -ne 3 ]; then
    usage
fi

# Menentukan file public key, username, dan IP address server
PUB_KEY_FILE=$1
USERNAME=$2
SERVER_IP=$3

# Memastikan file public key ada
if [ ! -f "$PUB_KEY_FILE" ]; then
    echo "Public key file does not exist: $PUB_KEY_FILE"
    exit 1
fi

# Menyalin public key ke server remote
ssh-copy-id -i "$PUB_KEY_FILE" "$USERNAME@$SERVER_IP"

# Mengecek apakah proses penyalinan berhasil
if [ $? -eq 0 ]; then
    echo "Public key successfully copied to $USERNAME@$SERVER_IP"
else
    echo "Failed to copy public key"
    exit 1
fi
