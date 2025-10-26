void main() {
  print("\n*** Multiple Catch - Versi Exception Umum ***\n");
  try {
    // Memaksa exception yang *bukan* RangeError atau ArgumentError:
    throw UnsupportedError("Operasi tidak didukung di konteks ini.");
  } on RangeError catch (e) {
    print("RangeError: $e");
  } on ArgumentError catch (e) {
    print("ArgumentError: $e");
  } catch (e) {
    print("Exception umum: ${e.runtimeType} → $e");
  }
  print("\nPernyataan di luar blok try-catch.");
}
