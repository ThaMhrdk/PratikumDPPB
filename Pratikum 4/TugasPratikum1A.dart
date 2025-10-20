class Kendaraan {
  void jalan() {
    print("Kendaraan sedang berjalan");
  }
}

class Mobil extends Kendaraan {
  void klakson() {
    print("Mobil membunyikan klakson: Tin tin!");
  }
}

class Pesawat extends Kendaraan {
  @override
  void jalan() {
    print("Pesawat taxi di landasan");
  }

  void terbang() {
    print("Pesawat sedang terbang");
  }
}

void main() {
  print("=== Kode A: Kendaraan dan Mobil (pewarisan tanpa overriding) ===");
  var k = Kendaraan();
  k.jalan();

  var m = Mobil();
  m.jalan();
  m.klakson();

  print("\n=== Kelas tambahan: Pesawat ===");
  var pesawat = Pesawat();
  pesawat.jalan();
  pesawat.terbang();
}
