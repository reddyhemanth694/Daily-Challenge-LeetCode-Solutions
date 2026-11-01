/*
Brute Force

class Solution {
  List<int> sumAndMultiply(String s, List<List<int>> queries) {
    const int mod = 1000000007;
    return queries.map((q) {
      int x = 0, sum = 0;
      for (int i = q[0]; i <= q[1]; i++) {
        int d = s.codeUnitAt(i) - 48;
        if (d != 0) {
          x = (x * 10 + d) % mod;
          sum += d;
        }
      }
      return x * sum % mod;
    }).toList();
  }
}
*/

/*
Better Approach

class Solution {
  List<int> sumAndMultiply(String s, List<List<int>> queries) {
    const int mod = 1000000007;
    int m = s.length;
    List<int> pre = List<int>.filled(m + 1, 0);
    List<int> cnt = List<int>.filled(m + 1, 0);
    List<int> sum = List<int>.filled(m + 1, 0);
    for (int i = 0; i < m; i++) {
      int d = s.codeUnitAt(i) - 48;
      pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % mod : pre[i];
      cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0);
      sum[i + 1] = sum[i] + d;
    }
    return queries.map((q) {
      int l = q[0], r = q[1] + 1;
      int x = ((pre[r] - pre[l] * 10.modPow(cnt[r] - cnt[l], mod)) % mod + mod) % mod;
      return x * (sum[r] - sum[l]) % mod;
    }).toList();
  }
}
*/

class Solution {
  List<int> sumAndMultiply(String s, List<List<int>> queries) {
    const int mod = 1000000007;
    int m = s.length;
    List<int> pre = List<int>.filled(m + 1, 0);
    List<int> pw = List<int>.filled(m + 1, 1);
    List<int> cnt = List<int>.filled(m + 1, 0);
    List<int> sum = List<int>.filled(m + 1, 0);
    for (int i = 0; i < m; i++) {
      int d = s.codeUnitAt(i) - 48;
      pw[i + 1] = pw[i] * 10 % mod;
      pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % mod : pre[i];
      cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0);
      sum[i + 1] = sum[i] + d;
    }
    return queries.map((q) {
      int l = q[0], r = q[1] + 1;
      int x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % mod + mod) % mod;
      return x * (sum[r] - sum[l]) % mod;
    }).toList();
  }
}