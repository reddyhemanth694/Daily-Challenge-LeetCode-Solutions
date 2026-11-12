/*
Brute Force

class Solution {
  int countNonDecreasingSubarrays(List<int> nums, int k) {
    int n = nums.length, ans = 0;
    for (int l = 0; l < n; l++) {
      int mx = 0, cost = 0;
      for (int r = l; r < n; r++) {
        if (nums[r] > mx) mx = nums[r];
        cost += mx - nums[r];
        if (cost > k) break;
        ans++;
      }
    }
    return ans;
  }
}
*/

/*
Better Approach

class Solution {
  int countNonDecreasingSubarrays(List<int> nums, int k) {
    int n = nums.length, lg = 1;
    while ((1 << lg) <= n) lg++;
    List<int> pre = List<int>.filled(n + 1, 0);
    for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
    List<List<int>> up = List.generate(lg, (_) => List<int>.filled(n + 1, n));
    List<List<int>> sum = List.generate(lg, (_) => List<int>.filled(n + 1, 0));
    List<int> st = [];
    for (int i = n - 1; i >= 0; i--) {
      while (st.isNotEmpty && nums[st.last] <= nums[i]) st.removeLast();
      int nx = st.isEmpty ? n : st.last;
      st.add(i);
      up[0][i] = nx;
      sum[0][i] = nums[i] * (nx - i) - (pre[nx] - pre[i]);
    }
    for (int j = 1; j < lg; j++) {
      for (int i = 0; i <= n; i++) {
        up[j][i] = up[j - 1][up[j - 1][i]];
        sum[j][i] = sum[j - 1][i] + sum[j - 1][up[j - 1][i]];
      }
    }
    int ans = 0;
    for (int l = 0; l < n; l++) {
      int cur = l, acc = 0;
      for (int j = lg - 1; j >= 0; j--) {
        if (cur < n && acc + sum[j][cur] <= k) {
          acc += sum[j][cur];
          cur = up[j][cur];
        }
      }
      if (cur == n) {
        ans += n - l;
        continue;
      }
      int lo = cur, hi = up[0][cur] - 1;
      while (lo < hi) {
        int mid = (lo + hi + 1) ~/ 2;
        if (acc + nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) {
          lo = mid;
        } else {
          hi = mid - 1;
        }
      }
      ans += lo - l + 1;
    }
    return ans;
  }
}
*/

class Solution {
  int countNonDecreasingSubarrays(List<int> nums, int k) {
    int n = nums.length;
    List<int> dq = List<int>.filled(n, 0);
    int head = n, tail = n, r = n - 1, ans = 0, cost = 0;
    for (int l = n - 1; l >= 0; l--) {
      while (head < tail && nums[dq[head]] <= nums[l]) {
        int i = dq[head++];
        int end = head < tail ? dq[head] : r + 1;
        cost += (nums[l] - nums[i]) * (end - i);
      }
      dq[--head] = l;
      while (cost > k) {
        cost -= nums[dq[tail - 1]] - nums[r];
        if (dq[tail - 1] == r) tail--;
        r--;
      }
      ans += r - l + 1;
    }
    return ans;
  }
}