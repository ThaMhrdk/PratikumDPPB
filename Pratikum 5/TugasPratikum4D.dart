void main() {
  print("\n*** Multiple Catch - Versi ArgumentError ***\n");
  try {
    // Memaksa ArgumentError secara eksplisit:
    throw ArgumentError("Ukuran array tidak boleh negatif!");
  } on RangeError catch (e) {
    print("RangeError: $e");
  } on ArgumentError catch (e) {
    print("ArgumentError: Anda membuat array dengan ukuran yang salah.");
    print("Detail error: $e");
  } catch (e) {
    print("Exception umum: ${e.runtimeType} → $e");
  }
  print("\nPernyataan di luar blok try-catch.");
}
