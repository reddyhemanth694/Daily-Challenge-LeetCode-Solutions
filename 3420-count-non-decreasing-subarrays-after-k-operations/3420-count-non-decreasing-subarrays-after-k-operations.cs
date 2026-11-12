/*
Brute Force

public class Solution {
    public long CountNonDecreasingSubarrays(int[] nums, int k) {
        int n = nums.Length;
        long ans = 0;
        for (int l = 0; l < n; l++) {
            long cost = 0;
            int mx = 0;
            for (int r = l; r < n; r++) {
                mx = Math.Max(mx, nums[r]);
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

public class Solution {
    public long CountNonDecreasingSubarrays(int[] nums, int k) {
        int n = nums.Length, lg = 1;
        while ((1 << lg) <= n) lg++;
        long[] pre = new long[n + 1];
        for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
        int[][] up = new int[lg][];
        long[][] sum = new long[lg][];
        for (int j = 0; j < lg; j++) {
            up[j] = new int[n + 1];
            sum[j] = new long[n + 1];
        }
        int[] st = new int[n];
        int top = 0;
        up[0][n] = n;
        for (int i = n - 1; i >= 0; i--) {
            while (top > 0 && nums[st[top - 1]] <= nums[i]) top--;
            int nx = top > 0 ? st[top - 1] : n;
            st[top++] = i;
            up[0][i] = nx;
            sum[0][i] = (long)nums[i] * (nx - i) - (pre[nx] - pre[i]);
        }
        for (int j = 1; j < lg; j++)
            for (int i = 0; i <= n; i++) {
                up[j][i] = up[j - 1][up[j - 1][i]];
                sum[j][i] = sum[j - 1][i] + sum[j - 1][up[j - 1][i]];
            }
        long ans = 0;
        for (int l = 0; l < n; l++) {
            int cur = l;
            long acc = 0;
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
                int mid = (lo + hi + 1) / 2;
                if (acc + (long)nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) lo = mid;
                else hi = mid - 1;
            }
            ans += lo - l + 1;
        }
        return ans;
    }
}
*/

public class Solution {
    public long CountNonDecreasingSubarrays(int[] nums, int k) {
        int n = nums.Length, head = n, tail = n, r = n - 1;
        int[] dq = new int[n];
        long ans = 0, cost = 0;
        for (int l = n - 1; l >= 0; l--) {
            while (head < tail && nums[dq[head]] <= nums[l]) {
                int i = dq[head++];
                int end = head < tail ? dq[head] : r + 1;
                cost += (long)(nums[l] - nums[i]) * (end - i);
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