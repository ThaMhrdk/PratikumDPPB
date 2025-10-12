//1.
abstract class Bottle {
  //2.
  void open();

  //4.
  factory Bottle() {
    return CokeBottle();
  }
}

//3.
class CokeBottle implements Bottle {
  @override
  void open() {
    print("Coke bottle is opened");
  }
}

void main() {
  //5.
  Bottle bottle = Bottle();

  bottle.open();
}

//1. abstract class Bottle digunakan sebagai antarmuka (interface) agar tidak bisa dibuat objek langsung.
//2. (Sudah Ditambahkan)
//3. (Sudah Ditambahkan)
//4. (Sudah Ditambahkan)
//5. (Sudah)
