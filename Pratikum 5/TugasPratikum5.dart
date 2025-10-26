class CreateExceptionHandling implements Exception {
  final String pesan;
  final int? bilangan;
  CreateExceptionHandling(this.pesan, [this.bilangan]);
  @override
  String toString() {
    return "Exception: $pesan, Bilangan = ${bilangan ?? 'null'}";
  }
}

class TryExceptionHandling {
  static int hitungFaktorial(int n) {
    if (n < 0) {
      throw CreateExceptionHandling("Bilangan tidak boleh negatif", n);
    }
    int hasil = 1;
    for (int i = n; i >= 1; i--) {
      hasil *= i;
    }
    return hasil;
  }
}

void main() {
  print("\n******** MEMBUAT CLASS EXCEPTION SENDIRI ********\n");
  try {
    print("Pada saat menghitung 5!");
    print("Hasil = ${TryExceptionHandling.hitungFaktorial(5)}");
    print("\nPada saat menghitung -5!");
    print("Hasil = ${TryExceptionHandling.hitungFaktorial(-5)}");
  } catch (e, s) {
    print("Terjadi Exception: $e");
    print("Detail Stack Trace:\n$s");
  }
}
