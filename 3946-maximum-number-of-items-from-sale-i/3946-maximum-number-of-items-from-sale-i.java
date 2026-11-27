class Solution {
    public int maximumSaleItems(int[][] items, int budget) {
        int n = items.length;
        int[] cnt = new int[1501];
        int minPrice = Integer.MAX_VALUE;
        for (int[] it : items) {
            cnt[it[0]]++;
            minPrice = Math.min(minPrice, it[1]);
        }
        int[] dp = new int[budget + 1];
        Arrays.fill(dp, -1);
        dp[0] = 0;
        for (int[] it : items) {
            int bonus = -1;
            for (int m = it[0]; m <= 1500; m += it[0]) bonus += cnt[m];
            int val = 1 + bonus, p = it[1];
            for (int b = budget; b >= p; b--) {
                if (dp[b - p] >= 0) dp[b] = Math.max(dp[b], dp[b - p] + val);
            }
        }
        int ans = 0;
        for (int b = 0; b <= budget; b++) {
            if (dp[b] >= 0) ans = Math.max(ans, dp[b] + (budget - b) / minPrice);
        }
        return ans;
    }
}