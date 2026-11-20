class Solution {
    public int maxSelectedElements(int[] nums) {
        Arrays.sort(nums);
        int[] dp = new int[1_000_003];
        int ans = 0;
        for (int x : nums) {
            dp[x + 1] = dp[x] + 1;
            dp[x] = (x > 0 ? dp[x - 1] : 0) + 1;
            ans = Math.max(ans, Math.max(dp[x], dp[x + 1]));
        }
        return ans;
    }
}