void main() {
  var identitas = {
    'Nama': 'Muhammad Anantha Mahardika Ridwan',
    'NIM': 707012400122,
    'Kelas': 'SIKC 48-01',
  };

  var kampus = {
    1: 'Sistem Informasi Kota Cerdas',
    2: 'FIT',
    3: 'Tel-U',
    'Kampus': 1,
  };

  print(identitas);
  print(kampus);
}

void rei() {
  var identitas = {
    'Nama': 'Michael Eluzai',
    'NIM': 707012400021,
    'Kelas': 'SIKC48-01',
  };

  var kampus = {
    1: 'Sistem Informasi Kota Cerdas',
    2: 'FIT',
    3: 'Tel-U',
    'Kampus': 1,
  };

  print(identitas);
  print(kampus);

  print("Nama saya: ${identitas['Nama']}");
  print("NIM saya: ${identitas['NIM']}");

  identitas['Alamat'] = 'Bandung';
  print(identitas);

  kampus.remove(2);
  print(kampus);
}
