import 'dart:io';

void main() {
  // Baca input
  String? line1 = stdin.readLineSync();
  if (line1 == null) return;
  int B = int.parse(line1.trim());

  String? line2 = stdin.readLineSync();
  if (line2 == null) return;
  String S = line2.trim();

  int N = S.length;
  const int MOD = 1000000007;

  List<int> dp = List<int>.filled(N + 1, 0);
  dp[N] = 1;

  for (int i = N - 1; i >= 0; i--) {
    int maxL = (N - i < 6 ? N - i : 6);
    for (int L = 1; L <= maxL; L++) {
      String sub = S.substring(i, i + L);

      if (L > 1 && sub[0] == '0') continue;

      int d;
      try {
        d = int.parse(sub);
      } catch (e) {
        continue;
      }

      if (d < B) {
        dp[i] = (dp[i] + dp[i + L]) % MOD;
      }
    }
  }

  int ans = 0;
  int maxL = (N < 6 ? N : 6);
  for (int L = 1; L <= maxL; L++) {
    String sub = S.substring(0, L);

    if (L > 1 && sub[0] == '0') continue;

    int d;
    try {
      d = int.parse(sub);
    } catch (e) {
      continue;
    }

    if (d < B && (d >= 1 || L == N)) {
      ans = (ans + dp[L]) % MOD;
    }
  }

  print(dp[0]);
}
