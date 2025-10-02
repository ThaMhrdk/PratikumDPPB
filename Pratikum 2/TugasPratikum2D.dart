void main() {
  var prodi = {
    'Sistem Informasi',
    'Teknologi Rekayasa Multimedia',
    'Sistem Informasi Kota Cerdas',
    'Sistem Informasi',
  };

  Set<String> prodiSet = prodi;

  prodiSet.add("Nama: Anantha");

  prodiSet.addAll({"Kelas: SIKC-48-01", "NIM: 707012400122"});

  print(prodiSet);
}
