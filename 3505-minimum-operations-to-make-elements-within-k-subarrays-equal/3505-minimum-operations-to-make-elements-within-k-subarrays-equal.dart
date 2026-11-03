/*
Brute Force

class Solution {
  int minOperations(List<int> nums, int x, int k) {
    int n = nums.length;
    int windowCost(int i) {
      List<int> w = nums.sublist(i, i + x)..sort();
      int med = w[x ~/ 2];
      int cost = 0;
      for (int v in w) cost += (v - med).abs();
      return cost;
    }
    int dfs(int i, int j) {
      if (j == 0) return 0;
      if (n - i < j * x) return 1 << 62;
      int skip = dfs(i + 1, j);
      int take = windowCost(i) + dfs(i + x, j - 1);
      return skip < take ? skip : take;
    }
    return dfs(0, k);
  }
}
*/

/*
Better Approach

class Solution {
  int minOperations(List<int> nums, int x, int k) {
    int n = nums.length;
    List<int> cost = List<int>.filled(n - x + 1, 0);
    for (int i = 0; i + x <= n; i++) {
      List<int> w = nums.sublist(i, i + x)..sort();
      int med = w[x ~/ 2];
      for (int v in w) cost[i] += (v - med).abs();
    }
    const int inf = 1 << 60;
    List<int> prev = List<int>.filled(n + 1, 0);
    for (int j = 1; j <= k; j++) {
      List<int> cur = List<int>.filled(n + 1, inf);
      for (int i = x; i <= n; i++) {
        int take = prev[i - x] + cost[i - x];
        cur[i] = cur[i - 1] < take ? cur[i - 1] : take;
      }
      prev = cur;
    }
    return prev[n];
  }
}
*/

class Solution {
  int minOperations(List<int> nums, int x, int k) {
    int n = nums.length;
    List<int> vals = nums.toSet().toList()..sort();
    int m = vals.length;
    Map<int, int> pos = {};
    for (int i = 0; i < m; i++) pos[vals[i]] = i + 1;
    List<int> idx = nums.map((v) => pos[v]!).toList();
    int top = 1;
    while (top * 2 <= m) top *= 2;
    List<int> cnt = List<int>.filled(m + 1, 0);
    List<int> sum = List<int>.filled(m + 1, 0);
    List<int> cost = List<int>.filled(n - x + 1, 0);
    int total = 0;
    int half = (x + 1) ~/ 2;
    for (int i = 0; i < n; i++) {
      for (int p = idx[i]; p <= m; p += p & -p) {
        cnt[p]++;
        sum[p] += nums[i];
      }
      total += nums[i];
      if (i >= x) {
        for (int p = idx[i - x]; p <= m; p += p & -p) {
          cnt[p]--;
          sum[p] -= nums[i - x];
        }
        total -= nums[i - x];
      }
      if (i >= x - 1) {
        int p = 0, need = half, lowCnt = 0, lowSum = 0;
        for (int step = top; step > 0; step >>= 1) {
          if (p + step <= m && cnt[p + step] < need) {
            p += step;
            need -= cnt[p];
            lowCnt += cnt[p];
            lowSum += sum[p];
          }
        }
        int med = vals[p];
        cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
      }
    }
    const int inf = 1 << 60;
    List<int> prev = List<int>.filled(n + 1, 0);
    for (int j = 1; j <= k; j++) {
      List<int> cur = List<int>.filled(n + 1, inf);
      for (int i = x; i <= n; i++) {
        int take = prev[i - x] + cost[i - x];
        cur[i] = cur[i - 1] < take ? cur[i - 1] : take;
      }
      prev = cur;
    }
    return prev[n];
  }
}