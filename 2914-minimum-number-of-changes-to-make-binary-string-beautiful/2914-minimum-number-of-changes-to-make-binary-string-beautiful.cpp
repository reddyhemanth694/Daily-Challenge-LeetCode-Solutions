/*
Brute Force

class Solution {
public:
    int solve(string& s, int i) {
        int n = s.size();
        if (i == n) return 0;
        int best = n, ones = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == '1') ones++;
            int len = j - i + 1;
            if (len % 2 == 0) best = min(best, min(ones, len - ones) + solve(s, j + 1));
        }
        return best;
    }

    int minChanges(string s) {
        return solve(s, 0);
    }
};
*/

/*
Better Approach

class Solution {
public:
    int minChanges(string s) {
        int n = s.size();
        vector<int> dp(n + 1, n);
        dp[0] = 0;
        for (int i = 0; i < n; i += 2) {
            int ones = 0;
            for (int j = i; j < n; j++) {
                if (s[j] == '1') ones++;
                int len = j - i + 1;
                if (len % 2 == 0) dp[j + 1] = min(dp[j + 1], dp[i] + min(ones, len - ones));
            }
        }
        return dp[n];
    }
};
*/

class Solution {
public:
    int minChanges(string s) {
        int ans = 0;
        for (int i = 0; i < (int)s.size(); i += 2) {
            if (s[i] != s[i + 1]) ans++;
        }
        return ans;
    }
};