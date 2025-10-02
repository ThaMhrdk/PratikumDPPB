bool isHEI(String c) => c == 'H' || c == 'E' || c == 'I';

int longestBeautifulHEI(String s) {
  final chars = s.split('');
  const starts = [
    ['H', 'E'],
    ['H', 'I'],
    ['E', 'H'],
    ['E', 'I'],
    ['I', 'H'],
    ['I', 'E'],
  ];

  int best = 0;

  for (final ab in starts) {
    String? last1;
    String? last2;
    int len = 0;

    for (final ch in chars) {
      if (!isHEI(ch)) continue;

      String expected;
      if (len == 0) {
        expected = ab[0];
      } else if (len == 1) {
        expected = ab[1];
      } else {
        final set = {'H', 'E', 'I'};
        set.remove(last1);
        set.remove(last2);
        expected = set.first;
      }

      if (ch == expected) {
        len += 1;
        last2 = last1;
        last1 = ch;
      }
    }
    if (len > best) best = len;
  }
  return best >= 3 ? best : -1;
}

void main() {
  final tests = ["HEI", "HEEIIH", "HHH", "HEIHEI"];
  for (final t in tests) {
    print("$t -> ${longestBeautifulHEI(t)}");
  }
}
