/*
Brute Force

public class Solution {
    public int MinimumSumSubarray(IList<int> nums, int l, int r) {
        int n = nums.Count, ans = int.MaxValue;
        for (int i = 0; i < n; i++) {
            for (int len = l; len <= r && i + len <= n; len++) {
                int sum = 0;
                for (int j = i; j < i + len; j++) sum += nums[j];
                if (sum > 0) ans = Math.Min(ans, sum);
            }
        }
        return ans == int.MaxValue ? -1 : ans;
    }
}
*/

/*
Better Approach

public class Solution {
    public int MinimumSumSubarray(IList<int> nums, int l, int r) {
        int n = nums.Count, ans = int.MaxValue;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n && j - i + 1 <= r; j++) {
                sum += nums[j];
                if (j - i + 1 >= l && sum > 0) ans = Math.Min(ans, sum);
            }
        }
        return ans == int.MaxValue ? -1 : ans;
    }
}
*/

public class Solution {
    public int MinimumSumSubarray(IList<int> nums, int l, int r) {
        int n = nums.Count, ans = int.MaxValue;
        int[] pre = new int[n + 1];
        for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
        var win = new SortedSet<long>();
        for (int j = l; j <= n; j++) {
            win.Add(((long)pre[j - l] << 7) + (j - l));
            if (j - r - 1 >= 0) win.Remove(((long)pre[j - r - 1] << 7) + (j - r - 1));
            var view = win.GetViewBetween(long.MinValue, ((long)pre[j] << 7) - 1);
            if (view.Count > 0) ans = Math.Min(ans, pre[j] - (int)(view.Max >> 7));
        }
        return ans == int.MaxValue ? -1 : ans;
    }
}