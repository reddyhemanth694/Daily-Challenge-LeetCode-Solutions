/*
Brute Force

public class Solution {
    int Solve(string s, int i) {
        int n = s.Length;
        if (i == n) return 0;
        int best = n, ones = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == '1') ones++;
            int len = j - i + 1;
            if (len % 2 == 0) best = Math.Min(best, Math.Min(ones, len - ones) + Solve(s, j + 1));
        }
        return best;
    }

    public int MinChanges(string s) {
        return Solve(s, 0);
    }
}
*/

/*
Better Approach

public class Solution {
    public int MinChanges(string s) {
        int n = s.Length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) dp[i] = n;
        for (int i = 0; i < n; i += 2) {
            int ones = 0;
            for (int j = i; j < n; j++) {
                if (s[j] == '1') ones++;
                int len = j - i + 1;
                if (len % 2 == 0) dp[j + 1] = Math.Min(dp[j + 1], dp[i] + Math.Min(ones, len - ones));
            }
        }
        return dp[n];
    }
}
*/

public class Solution {
    public int MinChanges(string s) {
        int ans = 0;
        for (int i = 0; i < s.Length; i += 2) {
            if (s[i] != s[i + 1]) ans++;
        }
        return ans;
    }
}