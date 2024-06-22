import pandas as pd
from datetime import datetime   

# load file csv ke dalam Dataframe
df_a = pd.read_csv('data_csv/branch_a.csv')
df_b = pd.read_csv('data_csv/branch_b.csv')
df_c = pd.read_csv('data_csv/branch_c.csv')

# Gabungkan semua file ke dalam satu DataFrame
df = pd.concat([df_a, df_b, df_c])

# clean data
# 1. hapus baris yang memiliki nilai NaN pada kolom transaction_id, date dan customer_id
df = df.dropna(subset=['transaction_id','date','customer_id'])

# 2. ubah format kolom date menjadi tipe datetime
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')

# 3. hilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru.
df = df.sort_values('date').drop_duplicates(subset='transaction_id', keep='last')

# 4. hitung total penjualan percabang dan simpan hasilnya ke file baru total_sales_per_branch.csv dengan kolom branch dan total.
df['total'] = df['quantity'] * df['price']
total_sales_per_branch = df.groupby('branch')['total'].sum().reset_index()

# simpan dengan file baru CSV
total_sales_per_branch.to_csv('data_csv/total_sales_per_branch.csv', index=False)

print("Pembersihan dan agregasi data selesai. Hasilnya disimpan dalam file 'total_sales_per_branch.csv' ")