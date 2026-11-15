/*
Brute Force

class Solution {
  int numOfSubarrays(List<int> arr) {
    const int mod = 1000000007;
    int n = arr.length, ans = 0;
    for (int i = 0; i < n; i++) {
      for (int j = i; j < n; j++) {
        int sum = 0;
        for (int k = i; k <= j; k++) sum += arr[k];
        if (sum % 2 == 1) ans = (ans + 1) % mod;
      }
    }
    return ans;
  }
}
*/

/*
Better Approach

class Solution {
  int numOfSubarrays(List<int> arr) {
    const int mod = 1000000007;
    int n = arr.length, ans = 0;
    for (int i = 0; i < n; i++) {
      int sum = 0;
      for (int j = i; j < n; j++) {
        sum += arr[j];
        if (sum % 2 == 1) ans = (ans + 1) % mod;
      }
    }
    return ans;
  }
}
*/

class Solution {
  int numOfSubarrays(List<int> arr) {
    const int mod = 1000000007;
    int odd = 0, even = 1, sum = 0, ans = 0;
    for (int x in arr) {
      sum += x;
      if (sum % 2 == 1) {
        ans = (ans + even) % mod;
        odd++;
      } else {
        ans = (ans + odd) % mod;
        even++;
      }
    }
    return ans;
  }
}