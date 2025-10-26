void main() {
  print("\n******** MENGGUNAKAN MULTIPLE CATCH ********\n");
  try {
    List<int> array = List.filled(9, 0);
    array[9] = 13;
    print("Elemen array indeks ke-9 adalah ${array[9]}");
    print("Pernyataan dalam blok try setelah bebas dari exception.");
  } on RangeError catch (e) {
    print(
      "RangeError: Anda mengakses array di luar indeks yang dideklarasikan.",
    );
    print("Detail error: $e");
  } on ArgumentError catch (e) {
    print("ArgumentError: Anda membuat array dengan ukuran yang salah.");
    print("Detail error: $e");
  } catch (e) {
    print("Exception umum: ${e.runtimeType} → $e");
  }
  print("\nPernyataan di luar blok try-catch.");
}
