#!/bin/bash

# Set threshold penggunaan disk
THRESHOLD=80

# Ambil penggunaan disk saat ini untuk root partition
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

# Periksa apakah penggunaan disk melebihi threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
  # Jika penggunaan disk melebihi threshold, kirim notifikasi
  SUBJECT="Disk Usage Alert: Usage is at ${USAGE}%"
  TO="danilsyaharihardjo@gmail.com"
  MESSAGE="Warning: Disk usage has exceeded ${THRESHOLD}%. Current usage is at ${USAGE}%."

  # Buat email body
  EMAIL="To: $TO\nSubject: $SUBJECT\n\n$MESSAGE"

  # Kirim email menggunakan sendmail
  echo -e "$EMAIL" | sendmail -t
fi
