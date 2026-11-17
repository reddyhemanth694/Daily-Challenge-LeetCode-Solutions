/*
Brute Force

class Solution {
    int solve(String s, int i) {
        int n = s.length();
        if (i == n) return 0;
        int best = n, ones = 0;
        for (int j = i; j < n; j++) {
            if (s.charAt(j) == '1') ones++;
            int len = j - i + 1;
            if (len % 2 == 0) best = Math.min(best, Math.min(ones, len - ones) + solve(s, j + 1));
        }
        return best;
    }

    public int minChanges(String s) {
        return solve(s, 0);
    }
}
*/

/*
Better Approach

class Solution {
    public int minChanges(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, n);
        dp[0] = 0;
        for (int i = 0; i < n; i += 2) {
            int ones = 0;
            for (int j = i; j < n; j++) {
                if (s.charAt(j) == '1') ones++;
                int len = j - i + 1;
                if (len % 2 == 0) dp[j + 1] = Math.min(dp[j + 1], dp[i] + Math.min(ones, len - ones));
            }
        }
        return dp[n];
    }
}
*/

class Solution {
    public int minChanges(String s) {
        int ans = 0;
        for (int i = 0; i < s.length(); i += 2) {
            if (s.charAt(i) != s.charAt(i + 1)) ans++;
        }
        return ans;
    }
}