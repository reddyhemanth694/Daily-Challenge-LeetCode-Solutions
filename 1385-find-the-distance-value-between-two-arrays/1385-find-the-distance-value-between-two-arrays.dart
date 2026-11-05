/*
Brute Force

class Solution {
  int findTheDistanceValue(List<int> arr1, List<int> arr2, int d) {
    int ans = 0;
    for (int a in arr1) {
      if (arr2.every((b) => (a - b).abs() > d)) ans++;
    }
    return ans;
  }
}
*/

/*
Better Approach

class Solution {
  int findTheDistanceValue(List<int> arr1, List<int> arr2, int d) {
    List<int> b = List<int>.from(arr2)..sort();
    int ans = 0;
    for (int a in arr1) {
      int lo = 0, hi = b.length;
      while (lo < hi) {
        int mid = (lo + hi) ~/ 2;
        if (b[mid] < a - d) {
          lo = mid + 1;
        } else {
          hi = mid;
        }
      }
      if (lo == b.length || b[lo] > a + d) ans++;
    }
    return ans;
  }
}
*/

class Solution {
  int findTheDistanceValue(List<int> arr1, List<int> arr2, int d) {
    List<int> pre = List<int>.filled(2202, 0);
    for (int v in arr2) pre[v + 1101]++;
    for (int i = 1; i < 2202; i++) pre[i] += pre[i - 1];
    int ans = 0;
    for (int a in arr1) {
      if (pre[a + d + 1101] == pre[a - d + 1100]) ans++;
    }
    return ans;
  }
}