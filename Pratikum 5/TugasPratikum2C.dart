void main() {
  print(
    "\n******** PROGRAM DENGAN EXCEPTION HANDLING (PEMBAGIAN VALID) ********\n",
  );
  try {
    int hasil = 9 ~/ 3; // pembagian valid
    print("Hasil pembagian = $hasil");
  } catch (e) {
    print("Exception tertangkap: $e");
  }
  print("\nPernyataan di luar blok try-catch.");
}
