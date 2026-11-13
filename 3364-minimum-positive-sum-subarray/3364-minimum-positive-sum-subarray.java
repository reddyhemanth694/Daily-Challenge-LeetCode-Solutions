/*
Brute Force

class Solution {
    public int minimumSumSubarray(List<Integer> nums, int l, int r) {
        int n = nums.size(), ans = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            for (int len = l; len <= r && i + len <= n; len++) {
                int sum = 0;
                for (int j = i; j < i + len; j++) sum += nums.get(j);
                if (sum > 0) ans = Math.min(ans, sum);
            }
        }
        return ans == Integer.MAX_VALUE ? -1 : ans;
    }
}
*/

/*
Better Approach

class Solution {
    public int minimumSumSubarray(List<Integer> nums, int l, int r) {
        int n = nums.size(), ans = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n && j - i + 1 <= r; j++) {
                sum += nums.get(j);
                if (j - i + 1 >= l && sum > 0) ans = Math.min(ans, sum);
            }
        }
        return ans == Integer.MAX_VALUE ? -1 : ans;
    }
}
*/

class Solution {
    public int minimumSumSubarray(List<Integer> nums, int l, int r) {
        int n = nums.size(), ans = Integer.MAX_VALUE;
        int[] pre = new int[n + 1];
        for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums.get(i);
        TreeMap<Integer, Integer> win = new TreeMap<>();
        for (int j = l; j <= n; j++) {
            win.merge(pre[j - l], 1, Integer::sum);
            if (j - r - 1 >= 0 && win.merge(pre[j - r - 1], -1, Integer::sum) == 0) win.remove(pre[j - r - 1]);
            Integer low = win.lowerKey(pre[j]);
            if (low != null) ans = Math.min(ans, pre[j] - low);
        }
        return ans == Integer.MAX_VALUE ? -1 : ans;
    }
}