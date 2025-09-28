import 'dart:io';

int go(int n) {
  int s = 0;
  int f = 1;
  for (int i = 2; i <= n; i++) {
    if (n % i == 0) {
      if (i - f > s) {
        s = i - f;
      }
      f = i;
    }
  }
  return s;
}

void main() {
  int result = go(30);
  print('go(30) $result');
}

/*a. Jawaban: Faktor dari 30: 2, 3, 5, 6, 10, 15, 30
Selisih terbesar antar faktor berurutan: 30 - 15 = 15
Jawaban: 15
*/

/*b. Pernyataan: SALAH. Contoh: go(6) hasilnya 3, padahal setengah dari 6 adalah 3. 
Tapi untuk go(8) hasilnya 4, setengah dari 8 adalah 4. Tidak selalu lebih dari atau sama dengan setengah N.
*/
