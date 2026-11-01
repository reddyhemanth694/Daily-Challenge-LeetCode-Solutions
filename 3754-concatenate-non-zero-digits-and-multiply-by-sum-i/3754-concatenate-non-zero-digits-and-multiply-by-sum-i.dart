/*
Brute Force

class Solution {
  int sumAndMultiply(int n) {
    String t = n.toString().replaceAll("0", "");
    if (t.isEmpty) return 0;
    int sum = 0;
    for (int c in t.codeUnits) sum += c - 48;
    return int.parse(t) * sum;
  }
}
*/

/*
Better Approach

class Solution {
  int sumAndMultiply(int n) {
    List<int> digits = [];
    for (; n > 0; n ~/= 10) digits.add(n % 10);
    int x = 0, sum = 0;
    for (int d in digits.reversed) {
      if (d != 0) {
        x = x * 10 + d;
        sum += d;
      }
    }
    return x * sum;
  }
}
*/

class Solution {
  int sumAndMultiply(int n) {
    int x = 0, sum = 0, p = 1;
    for (; n > 0; n ~/= 10) {
      int d = n % 10;
      if (d != 0) {
        x += d * p;
        sum += d;
        p *= 10;
      }
    }
    return x * sum;
  }
}