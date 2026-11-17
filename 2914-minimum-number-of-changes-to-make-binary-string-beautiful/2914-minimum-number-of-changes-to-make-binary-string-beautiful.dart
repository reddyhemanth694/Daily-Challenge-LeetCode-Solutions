/*
Brute Force

class Solution {
  int solve(String s, int i) {
    int n = s.length;
    if (i == n) return 0;
    int best = n, ones = 0;
    for (int j = i; j < n; j++) {
      if (s[j] == '1') ones++;
      int len = j - i + 1;
      if (len % 2 == 0) {
        int cost = (ones < len - ones ? ones : len - ones) + solve(s, j + 1);
        if (cost < best) best = cost;
      }
    }
    return best;
  }

  int minChanges(String s) {
    return solve(s, 0);
  }
}
*/

/*
Better Approach

class Solution {
  int minChanges(String s) {
    int n = s.length;
    List<int> dp = List<int>.filled(n + 1, n);
    dp[0] = 0;
    for (int i = 0; i < n; i += 2) {
      int ones = 0;
      for (int j = i; j < n; j++) {
        if (s[j] == '1') ones++;
        int len = j - i + 1;
        if (len % 2 == 0) {
          int cost = dp[i] + (ones < len - ones ? ones : len - ones);
          if (cost < dp[j + 1]) dp[j + 1] = cost;
        }
      }
    }
    return dp[n];
  }
}
*/

class Solution {
  int minChanges(String s) {
    int ans = 0;
    for (int i = 0; i < s.length; i += 2) {
      if (s[i] != s[i + 1]) ans++;
    }
    return ans;
  }
}