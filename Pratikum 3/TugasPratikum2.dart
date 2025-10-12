class Mobil {
  String merk;
  String warna;
  int kecepatan;

  Mobil(this.merk, this.warna, this.kecepatan);

  void jalan() {
    print("Mobil $merk melaju dengan kecepatan $kecepatan km/jam");
  }

  // Method baru untuk mengubah kecepatan (Nomor1)
  void ubahKecepatan(int nilai) {
    if (nilai <= 0) {
      print("Kecepatan tidak boleh negatif!");
    } else {
      kecepatan = nilai;
    }
  }

  // Method baru untuk berhenti kecepatan (Nomor2)
  void berhenti() {
    kecepatan = 0;
    print("Mobil berhenti");
  }
}

void main() {
  var mobil1 = Mobil("Toyota", "Merah", 60);

  print("== MOBIL 1 ==");
  mobil1.jalan();
  mobil1.ubahKecepatan(-10);
  mobil1.jalan();
  mobil1.berhenti();

  //Objek Mobil baru Ditambahkan
  print("== MOBIL 2 ==");
  var mobil2 = Mobil("Honda", "Pink", 140);
  mobil2.jalan();
  mobil2.ubahKecepatan(200);
  mobil2.jalan();
  mobil2.berhenti();
}

/*
1. (Sudah ditambahkan)
2. (Sudah ditambahkan)
3. (Sudah ditambahkan)

*/
