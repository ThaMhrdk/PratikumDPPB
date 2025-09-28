import 'dart:io';

void main() {
  print("Masukkan basis B:");
  int B = int.parse(stdin.readLineSync()!);

  print("Masukkan string Y:");
  String Y = stdin.readLineSync()!;

  print("hasilnya adalah :");
  print(solve(B, Y));
}

int solve(int B, String Y) {
  if (Y == "0") return 1;

  int n = Y.length;
  List<List<int>> dp = List.generate(n + 1, (_) => List.filled(2, 0));
  dp[0][0] = 1;

  for (int i = 0; i < n; i++) {
    for (int started = 0; started < 2; started++) {
      if (dp[i][started] == 0) continue;

      for (int len = 1; len <= 6 && i + len <= n; len++) {
        int digit = int.parse(Y.substring(i, i + len));
        bool valid = false;

        if (len == 1) {
          valid = digit < B;
        } else {
          int min = 1;
          for (int j = 1; j < len; j++) min *= 10;
          valid = digit >= min && digit < B;
        }

        if (valid) {
          int newStarted = (digit > 0) ? 1 : started;
          dp[i + len][newStarted] =
              (dp[i + len][newStarted] + dp[i][started]) % 1000000007;
        }
      }
    }
  }

  return dp[n][1];
}
