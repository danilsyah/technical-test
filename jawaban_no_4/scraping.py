import sys
import requests
import pandas as pd

def get_universities(country):
    # URL dari API dengan parameter pencarian negara
    url = f'http://universities.hipolabs.com/search?country={country}'
    
    # melakukan permintaan GET ke API
    response = requests.get(url)
    
    # memastikan bahwa permintaan berhasil
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print("Error fetching data from API")
        return None
    

def filter_universities_with_state(data):
    # menyaring data yang memiliki "state-province"
    filtered_data = [uni for uni in data if uni['state-province'] and uni['state-province'] != 'null']
    return filtered_data

def create_table(data):
    # membuat dataframe dari data
    df = pd.DataFrame(data)
    
    # mengubah kolom menjadi sesuai dengan kebutuhan
    df = df.rename(columns={
        'name':'Name',
        'web_pages' : 'Web Pages',
        'country' : 'Country',
        'domains' : 'Domains',
        'state-province' : 'State Province'
    })
    
    # memilih hanya kolom yang diinginkan
    df = df[['Name', 'Web Pages', 'Country', 'Domains', 'State Province']]
    
    return df
    

if __name__ == '__main__':
    
    # Memastikan ada parameter yang diberikann
    if len(sys.argv) > 1:
        country = sys.argv[1]
    else:
        print('Parameter nama negara belum di isi, example = python scraping.py "United States"')
        sys.exit(1)
    
    # mengambil apakah data berhasil diambil
    universities_data = get_universities(country)

    # memeriksan apakah data berhasil diambil
    try:
        if universities_data:
            # menyaring data yang memiliki "state-province"
            filtered_data = filter_universities_with_state(universities_data)
            
            # membuat tabel dari data yang difilter
            universities_table = create_table(filtered_data)
            
            # menampilkan tabel
            print(universities_table)
        else:
            print("Data not available")
    except Exception as e:
        print(f"Error: {e}")