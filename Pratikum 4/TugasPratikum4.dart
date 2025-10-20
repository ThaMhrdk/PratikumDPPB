class Mahasiswa {
  String nama;
  Mahasiswa(this.nama);
}

class Universitas {
  List<Mahasiswa> daftarMhs = [];
}

class Mesin {
  void nyala() {
    print("Mesin menyala dan siap menjalankan mobil");
  }
}

class Mobil {
  final Mesin mesin = Mesin();
  void nyalakanMobil() {
    mesin.nyala();
    print("Mobil siap jalan!");
  }
}

void main() {
  print("=== AGREGASI ===");
  Universitas? u = Universitas();
  var m1 = Mahasiswa("Muhammad Anantha");
  var m2 = Mahasiswa("Michael Elawje");
  u.daftarMhs.addAll([m1, m2]);
  print("Mahasiswa: ${u.daftarMhs.map((m) => m.nama).toList()}");
  u = null;
  print("Setelah Universitas dihapus, Mahasiswa tetap ada:");
  print("Nama Mahasiswa: ${m1.nama}, ${m2.nama}");

  print("\n=== KOMPOSISI ===");
  Mobil? mobil = Mobil();
  mobil.nyalakanMobil();
  mobil = null;
  print(
    "Jika Mobil dihapus, Mesin di dalamnya juga ikut dianggap tidak berguna.",
  );
}
