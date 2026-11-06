/*
Brute Force

class Solution {
  List<int> countServers(int n, List<List<int>> logs, int x, List<int> queries) {
    return queries.map((q) {
      List<bool> seen = List<bool>.filled(n + 1, false);
      int cnt = 0;
      for (List<int> lg in logs) {
        if (lg[1] >= q - x && lg[1] <= q && !seen[lg[0]]) {
          seen[lg[0]] = true;
          cnt++;
        }
      }
      return n - cnt;
    }).toList();
  }
}
*/

/*
Better Approach

class Solution {
  List<int> countServers(int n, List<List<int>> logs, int x, List<int> queries) {
    logs.sort((a, b) => a[1].compareTo(b[1]));
    int m = logs.length;
    List<int> stamp = List<int>.filled(n + 1, -1);
    List<int> ans = List<int>.filled(queries.length, 0);
    for (int i = 0; i < queries.length; i++) {
      int q = queries[i];
      int lo = 0, hi = m;
      while (lo < hi) {
        int mid = (lo + hi) ~/ 2;
        if (logs[mid][1] < q - x) {
          lo = mid + 1;
        } else {
          hi = mid;
        }
      }
      int cnt = 0;
      for (int j = lo; j < m && logs[j][1] <= q; j++) {
        if (stamp[logs[j][0]] != i) {
          stamp[logs[j][0]] = i;
          cnt++;
        }
      }
      ans[i] = n - cnt;
    }
    return ans;
  }
}
*/

class Solution {
  List<int> countServers(int n, List<List<int>> logs, int x, List<int> queries) {
    logs.sort((a, b) => a[1].compareTo(b[1]));
    int m = logs.length;
    List<int> idx = List<int>.generate(queries.length, (i) => i)..sort((a, b) => queries[a].compareTo(queries[b]));
    List<int> cnt = List<int>.filled(n + 1, 0);
    List<int> ans = List<int>.filled(queries.length, 0);
    int l = 0, r = 0, distinct = 0;
    for (int i in idx) {
      int q = queries[i];
      while (r < m && logs[r][1] <= q) {
        if (cnt[logs[r][0]]++ == 0) distinct++;
        r++;
      }
      while (l < r && logs[l][1] < q - x) {
        if (--cnt[logs[l][0]] == 0) distinct--;
        l++;
      }
      ans[i] = n - distinct;
    }
    return ans;
  }
}