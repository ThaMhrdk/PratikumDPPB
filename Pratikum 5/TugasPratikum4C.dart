void main() {
  print("\n*** Multiple Catch - Versi tanpa exception ***\n");
  try {
    List<int> array = List.filled(9, 0);
    array[8] = 13; // indeks valid: 0..8
    print("Elemen array indeks ke-8 adalah ${array[8]}");
    print("Pernyataan dalam blok try setelah bebas dari exception.");
  } on RangeError catch (e) {
    print("RangeError: $e");
  } on ArgumentError catch (e) {
    print("ArgumentError: $e");
  } catch (e) {
    print("Exception umum: ${e.runtimeType} → $e");
  }
  print("\nPernyataan di luar blok try-catch.");
}
