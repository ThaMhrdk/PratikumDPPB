class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;
  // Method untuk menampilkan data
  void tampilkanData() {
    print("Nama : $nama");
    print("NIM : $nim");
    print("Jurusan : $jurusan");
  }
}

void main() {
  var m1 = Mahasiswa();
  m1.nama = "Budi";
  m1.nim = 12345;
  m1.jurusan = "SIKC";
  // Memanggil method untuk print
  m1.tampilkanData();
}

/*
A. (Sudah, Output dari kedua kode A dan B sama)
B. (Perbedaanya dari sisi Kerapian, Yang A Kurang eifisen dan lebih panjang
    Yang B Lebih singkat dan terstruktur, dan cara Inisiasi yang itu Propertinya
    diisii satu per satu Sedang yang B itu Properti langsung diisi saat objek nya dibuat)
C. (Sudah saya tambahkan Ada TugasPratikum1B.dart)
D. (Yang Lebih efisien itu kode yang B karena pakai constructor Karena
    Datanya langsung diinisialisasi saat objke dibuat, Berfungsi untuk mencegah null
    Kode singkat dan efisien, jika dalam Sekala besar itu jadi aman digunakan
    Mengurangi risiko kelalaian orang saat mengisi data di objeknya)
*/
