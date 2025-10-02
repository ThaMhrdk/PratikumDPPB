import 'dart:collection';

void main() {
  Queue<String> antrian = Queue<String>();
  antrian.addAll(["Anantha", "Michael", "Fadhil"]);
  print("Daftar antrian awal: $antrian");

  antrian.add("Eben");
  antrian.add("Ammar");
  print("Antrian setelah penambahan data: $antrian");

  Queue<String> nimQueue = Queue<String>();
  nimQueue.addAll([
    "707012400122",
    "707012400021",
    "707012400084",
    "707012400072",
    "707012400052",
  ]);
  print("\nAntrian NIM: $nimQueue");

  while (nimQueue.isNotEmpty) {
    String keluar = nimQueue.removeFirst();
    print("Elemen keluar: $keluar");
    print("Sisa antrian: $nimQueue");
  }
}
