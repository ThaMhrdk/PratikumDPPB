// Class Bebek - merepresentasikan setiap bebek
class Bebek {
  int nomor;
  int kemanisanFavorit;

  // Constructor untuk inisialisasi bebek
  Bebek(this.nomor, this.kemanisanFavorit);

  // Method untuk menghitung ketidakpuasan
  int hitungKetidakpuasan(int kemanisanDiterima) {
    int selisih = kemanisanFavorit - kemanisanDiterima;
    if (selisih < 0) {
      selisih = -selisih; // Ubah jadi positif (nilai mutlak)
    }
    return selisih;
  }

  // Method untuk menampilkan info bebek
  void tampilkanInfo() {
    print("Bebek $nomor - Kemanisan Favorit: $kemanisanFavorit");
  }
}

// Class Bekatul - merepresentasikan jenis bekatul
class Bekatul {
  int tingkatKemanisan;

  // Constructor untuk inisialisasi bekatul
  Bekatul(this.tingkatKemanisan);
}

// Class untuk mengelola kelompok gosip
class KelompokGosip {
  List<Bebek> anggota = []; // Daftar bebek dalam kelompok

  // Method untuk menambah bebek ke kelompok
  void tambahBebek(Bebek bebek) {
    anggota.add(bebek);
  }

  // Method untuk mencari bekatul terbaik untuk kelompok ini
  int cariBekaTulTerbaik(List<Bekatul> daftarBekatul) {
    int ketidakpuasanTerkecil = 999999999;
    int bekatulTerbaik = 0;

    // Coba setiap jenis bekatul
    for (var bekatul in daftarBekatul) {
      int totalKetidakpuasan = 0;

      // Hitung total ketidakpuasan untuk kelompok ini
      for (var bebek in anggota) {
        totalKetidakpuasan += bebek.hitungKetidakpuasan(
          bekatul.tingkatKemanisan,
        );
      }

      // Simpan yang paling kecil
      if (totalKetidakpuasan < ketidakpuasanTerkecil) {
        ketidakpuasanTerkecil = totalKetidakpuasan;
        bekatulTerbaik = bekatul.tingkatKemanisan;
      }
    }

    print("  Bekatul terbaik: kemanisan $bekatulTerbaik");
    print("  Ketidakpuasan: $ketidakpuasanTerkecil");
    return ketidakpuasanTerkecil;
  }

  // Method untuk menampilkan anggota kelompok
  void tampilkanAnggota() {
    for (var bebek in anggota) {
      print("  - Bebek ${bebek.nomor} (favorit: ${bebek.kemanisanFavorit})");
    }
  }
}

// Class utama untuk menyelesaikan masalah
class GosipBekatul {
  List<Bebek> daftarBebek = [];
  List<Bekatul> daftarBekatul = [];
  List<int> kelompokBebek;

  // Constructor
  GosipBekatul(int jumlahBebek)
    : kelompokBebek = List.generate(jumlahBebek + 1, (i) => i);

  // Method untuk menambah bebek
  void tambahBebek(int nomor, int kemanisanFavorit) {
    daftarBebek.add(Bebek(nomor, kemanisanFavorit));
  }

  // Method untuk menambah bekatul
  void tambahBekatul(int tingkatKemanisan) {
    daftarBekatul.add(Bekatul(tingkatKemanisan));
  }

  // Method untuk mencari kelompok bebek
  int cariKelompok(int bebekNomor) {
    if (kelompokBebek[bebekNomor] == bebekNomor) {
      return bebekNomor;
    }
    return cariKelompok(kelompokBebek[bebekNomor]);
  }

  // Method untuk menggabungkan dua kelompok gosip
  void gabungKelompok(int bebek1, int bebek2) {
    int kelompok1 = cariKelompok(bebek1);
    int kelompok2 = cariKelompok(bebek2);

    if (kelompok1 != kelompok2) {
      kelompokBebek[kelompok2] = kelompok1;
    }
  }

  // Method utama untuk menghitung total ketidakpuasan
  int hitungHasil() {
    // Kelompokkan bebek berdasarkan gosip
    Map<int, KelompokGosip> kelompokGosip = {};

    for (var bebek in daftarBebek) {
      int kelompok = cariKelompok(bebek.nomor);

      if (!kelompokGosip.containsKey(kelompok)) {
        kelompokGosip[kelompok] = KelompokGosip();
      }

      kelompokGosip[kelompok]!.tambahBebek(bebek);
    }

    // Hitung total ketidakpuasan
    int totalKetidakpuasan = 0;
    int nomorKelompok = 1;

    print("\n════════════════════════════════════");
    print("PEMBAGIAN KELOMPOK GOSIP");
    print("════════════════════════════════════");

    for (var kelompok in kelompokGosip.values) {
      print("\nKelompok $nomorKelompok:");
      kelompok.tampilkanAnggota();

      int ketidakpuasanKelompok = kelompok.cariBekaTulTerbaik(daftarBekatul);

      totalKetidakpuasan += ketidakpuasanKelompok;
      nomorKelompok++;
    }

    return totalKetidakpuasan;
  }
}

void main() {
  print("════════════════════════════════════");
  print("   PROGRAM GOSIP BEKATUL (OOP)");
  print("════════════════════════════════════\n");

  // ===== CONTOH 1 =====
  print("CONTOH 1:");
  print("-----------------");

  // Data: 8 bebek, 4 jenis bekatul, 6 hubungan gosip
  var program1 = GosipBekatul(8);

  // Tambah bebek dengan kemanisan favorit masing-masing
  program1.tambahBebek(1, 10);
  program1.tambahBebek(2, 20);
  program1.tambahBebek(3, 30);
  program1.tambahBebek(4, 40);
  program1.tambahBebek(5, 50);
  program1.tambahBebek(6, 60);
  program1.tambahBebek(7, 70);
  program1.tambahBebek(8, 80);

  // Tambah jenis bekatul yang tersedia
  program1.tambahBekatul(30);
  program1.tambahBekatul(40);
  program1.tambahBekatul(50);
  program1.tambahBekatul(60);

  // Hubungan gosip (bebek mana saja yang saling bergosip)
  program1.gabungKelompok(1, 8);
  program1.gabungKelompok(2, 7);
  program1.gabungKelompok(3, 5);
  program1.gabungKelompok(3, 6);
  program1.gabungKelompok(5, 6);
  program1.gabungKelompok(6, 8);

  // Hitung dan tampilkan hasil
  int hasil1 = program1.hitungHasil();

  print("\n════════════════════════════════════");
  print("HASIL AKHIR: $hasil1");
  print("════════════════════════════════════\n\n");

  // ===== CONTOH 2 =====
  print("CONTOH 2:");
  print("-----------------");

  // Data: 4 bebek, 3 jenis bekatul, 0 hubungan gosip
  var program2 = GosipBekatul(4);

  // Tambah bebek
  program2.tambahBebek(1, 1);
  program2.tambahBebek(2, 2);
  program2.tambahBebek(3, 13);
  program2.tambahBebek(4, 14);

  // Tambah jenis bekatul
  program2.tambahBekatul(20);
  program2.tambahBekatul(10);
  program2.tambahBekatul(20);

  // Tidak ada hubungan gosip (k=0)

  // Hitung dan tampilkan hasil
  int hasil2 = program2.hitungHasil();

  print("\n════════════════════════════════════");
  print("HASIL AKHIR: $hasil2");
  print("════════════════════════════════════");
}
