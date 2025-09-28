int panas(int x) {
  if (x == 0) return 0;
  return (x % 10) + panas(x ~/ 10);
}

int dingin(int x, int y) {
  int air = 0;
  while (panas(air) != x) {
    air += y;
  }
  return air;
}
