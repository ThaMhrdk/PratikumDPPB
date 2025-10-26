import 'dart:io';

// Custom Exception 1: Untuk input kosong
class InputKosongException implements Exception {
  String pesan;
  InputKosongException(this.pesan);

  @override
  String toString() => "ERROR: $pesan tidak boleh kosong!";
}

// Custom Exception 2: Untuk tahun tidak valid
class TahunTidakValidException implements Exception {
  String input;
  TahunTidakValidException(this.input);

  @override
  String toString() => "ERROR: '$input' bukan tahun yang valid!";
}

// Custom Exception 3: Untuk durasi tidak valid
class DurasiTidakValidException implements Exception {
  String input;
  DurasiTidakValidException(this.input);

  @override
  String toString() => "ERROR: '$input' bukan durasi yang valid!";
}

void main() {
  print("\n===== PROGRAM DATA FILM =====\n");

  // Variabel untuk menyimpan data
  String? judul;
  int? tahun;
  int? durasi;

  // Blok TRY - coba jalankan kode ini
  try {
    // INPUT 1: Judul Film
    print("Masukkan Judul Film: ");
    judul = stdin.readLineSync();

    // Cek apakah kosong
    if (judul == null || judul.isEmpty) {
      throw InputKosongException("Judul film");
    }

    // INPUT 2: Tahun Rilis
    print("Masukkan Tahun Rilis: ");
    String? inputTahun = stdin.readLineSync();

    // Cek apakah kosong
    if (inputTahun == null || inputTahun.isEmpty) {
      throw InputKosongException("Tahun rilis");
    }

    // Ubah string ke angka
    tahun = int.tryParse(inputTahun);

    // Cek apakah angka valid dan dalam range
    if (tahun == null || tahun < 1900 || tahun > 2100) {
      throw TahunTidakValidException(inputTahun);
    }

    // INPUT 3: Durasi Film
    print("Masukkan Durasi (menit): ");
    String? inputDurasi = stdin.readLineSync();

    // Cek apakah kosong
    if (inputDurasi == null || inputDurasi.isEmpty) {
      throw InputKosongException("Durasi film");
    }

    // Ubah string ke angka
    durasi = int.tryParse(inputDurasi);

    // Cek apakah angka valid dan positif
    if (durasi == null || durasi <= 0) {
      throw DurasiTidakValidException(inputDurasi);
    }

    // Jika sampai sini berarti semua input BENAR
    print("\n===== DATA FILM BERHASIL DISIMPAN =====");
    print("Judul       : $judul");
    print("Tahun Rilis : $tahun");
    print("Durasi      : $durasi menit");
    print("=======================================\n");
  }
  // CATCH 1: Tangani error input kosong
  on InputKosongException catch (e) {
    print("\n$e");
    print("Mohon isi semua data!\n");
  }
  // CATCH 2: Tangani error tahun tidak valid
  on TahunTidakValidException catch (e) {
    print("\n$e");
    print("Gunakan angka tahun antara 1900-2100!\n");
  }
  // CATCH 3: Tangani error durasi tidak valid
  on DurasiTidakValidException catch (e) {
    print("\n$e");
    print("Gunakan angka positif untuk durasi!\n");
  }
  // FINALLY: Selalu dijalankan (ada error atau tidak)
  finally {
    print("======================================");
    print("Program selesai dijalankan");
    print("======================================");
  }
}
