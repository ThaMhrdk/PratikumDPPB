import 'dart:io';

// Exception 1: Username/Password Salah
class LoginSalahException implements Exception {
  @override
  String toString() => "Login Failed, Username/Password Salah";
}

// Exception 2: Karakter Tidak Valid
class KarakterInvalidException implements Exception {
  String pesan;
  KarakterInvalidException(this.pesan);

  @override
  String toString() => "Login Failed, $pesan";
}

void main() {
  print("\n===== SISTEM LOGIN =====\n");

  // Data login yang benar
  String userBenar = "admin123";
  String passBenar = "pass456";

  // Blok TRY - coba jalankan login
  try {
    // INPUT USERNAME
    print("Username: ");
    String? username = stdin.readLineSync();

    // Cek kosong
    if (username == null || username.isEmpty) {
      throw LoginSalahException();
    }

    // Cek karakter satu per satu
    for (int i = 0; i < username.length; i++) {
      String huruf = username[i];

      // Cek apakah bukan huruf atau angka
      bool bukanHuruf = huruf.compareTo('a') < 0 || huruf.compareTo('z') > 0;
      bool bukanHurufBesar =
          huruf.compareTo('A') < 0 || huruf.compareTo('Z') > 0;
      bool bukanAngka = huruf.compareTo('0') < 0 || huruf.compareTo('9') > 0;

      // Jika bukan huruf DAN bukan angka = INVALID
      if (bukanHuruf && bukanHurufBesar && bukanAngka) {
        throw KarakterInvalidException(
          "Username mengandung karakter '$huruf' yang tidak diizinkan",
        );
      }
    }

    // INPUT PASSWORD
    print("Password: ");
    String? password = stdin.readLineSync();

    // Cek kosong
    if (password == null || password.isEmpty) {
      throw LoginSalahException();
    }

    // Cek karakter satu per satu
    for (int i = 0; i < password.length; i++) {
      String huruf = password[i];

      // Cek apakah bukan huruf atau angka
      bool bukanHuruf = huruf.compareTo('a') < 0 || huruf.compareTo('z') > 0;
      bool bukanHurufBesar =
          huruf.compareTo('A') < 0 || huruf.compareTo('Z') > 0;
      bool bukanAngka = huruf.compareTo('0') < 0 || huruf.compareTo('9') > 0;

      // Jika bukan huruf DAN bukan angka = INVALID
      if (bukanHuruf && bukanHurufBesar && bukanAngka) {
        throw KarakterInvalidException(
          "Password mengandung karakter '$huruf' yang tidak diizinkan",
        );
      }
    }

    // CEK KECOCOKAN username dan password
    if (username != userBenar || password != passBenar) {
      throw LoginSalahException();
    }

    // JIKA SAMPAI SINI = LOGIN BERHASIL
    print("\n===================================");
    print("LOGIN BERHASIL!");
    print("Selamat datang, $username");
    print("===================================\n");
  }
  // CATCH 1: Tangani login salah
  on LoginSalahException catch (e) {
    print("\n$e");
    print("Silakan coba lagi!\n");
  }
  // CATCH 2: Tangani karakter invalid
  on KarakterInvalidException catch (e) {
    print("\n$e");
    print("Gunakan hanya huruf dan angka!\n");
  }
  // CATCH 3: Tangani error lainnya
  catch (e) {
    print("\nError: $e\n");
  }
  // FINALLY: Selalu dijalankan
  finally {
    print("===================================");
    print("Program login selesai");
    print("===================================");
  }
}
