class Kendaraan {
  void jalan() {
    print("Kendaraan sedang berjalan");
  }
}

class Motor extends Kendaraan {
  @override
  void jalan() {
    print("Motor melaju di jalan raya");
  }

  void bunyiMesin() {
    print("Motor berbunyi: Brummm!");
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
  print("=== Kode B: Motor (pewarisan dengan overriding) ===");
  var motor = Motor();
  motor.jalan();
  motor.bunyiMesin();

  print("\n=== Kelas tambahan: Pesawat ===");
  var pesawat = Pesawat();
  pesawat.jalan();
  pesawat.terbang();
}
