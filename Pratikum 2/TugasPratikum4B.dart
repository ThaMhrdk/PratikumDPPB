void main() {
  List<int?> list1 = [1, 2, null];
  print(list1);

  var list3 = [0, ...list1];
  print(list3);
  print(list3.length);
}
