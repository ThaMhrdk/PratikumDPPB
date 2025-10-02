void main() {
  final List<String?> list = List.filled(4, null);

  list[1] = "Nama Anda";
  list[2] = "NIM Anda";

  print(list);

  assert(list.length == 4);
  assert(list[1] == "Nama Anda");
  assert(list[2] == "NIM Anda");
}
