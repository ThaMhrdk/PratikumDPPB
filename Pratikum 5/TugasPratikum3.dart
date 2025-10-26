void main() {
  print("\n******** PROGRAM DENGAN BLOCK FINALLY ********\n");

  try {
    int hasil = 9 ~/ 0;
    print("Hasil pembagian = $hasil");
    print("Pernyataan dalam blok try setelah bebas dari exception.");
  } catch (e) {
    print("Exception tertangkap: $e");
    print("Terjadi error karena pembagian dengan nol.");
  } finally {
    print("\nPernyataan dalam blok finally.");
  }

  print("\nPernyataan di luar blok try-catch-finally.");
}
