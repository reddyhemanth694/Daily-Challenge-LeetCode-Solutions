/*
Brute Force

public class Solution {
    public int[] SumAndMultiply(string s, int[][] queries) {
        const long MOD = 1000000007;
        int[] ans = new int[queries.Length];
        for (int k = 0; k < queries.Length; k++) {
            long x = 0, sum = 0;
            for (int i = queries[k][0]; i <= queries[k][1]; i++) {
                int d = s[i] - '0';
                if (d != 0) {
                    x = (x * 10 + d) % MOD;
                    sum += d;
                }
            }
            ans[k] = (int)(x * sum % MOD);
        }
        return ans;
    }
}
*/

/*
Better Approach

public class Solution {
    const long MOD = 1000000007;

    long Power(long b, int e) {
        long r = 1;
        while (e > 0) {
            if ((e & 1) == 1) r = r * b % MOD;
            b = b * b % MOD;
            e >>= 1;
        }
        return r;
    }

    public int[] SumAndMultiply(string s, int[][] queries) {
        int m = s.Length;
        long[] pre = new long[m + 1];
        int[] cnt = new int[m + 1], sum = new int[m + 1];
        for (int i = 0; i < m; i++) {
            int d = s[i] - '0';
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
            cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0);
            sum[i + 1] = sum[i] + d;
        }
        int[] ans = new int[queries.Length];
        for (int k = 0; k < queries.Length; k++) {
            int l = queries[k][0], r = queries[k][1] + 1;
            long x = ((pre[r] - pre[l] * Power(10, cnt[r] - cnt[l])) % MOD + MOD) % MOD;
            ans[k] = (int)(x * (sum[r] - sum[l]) % MOD);
        }
        return ans;
    }
}
*/

public class Solution {
    public int[] SumAndMultiply(string s, int[][] queries) {
        const long MOD = 1000000007;
        int m = s.Length;
        long[] pre = new long[m + 1], pw = new long[m + 1];
        int[] cnt = new int[m + 1], sum = new int[m + 1];
        pw[0] = 1;
        for (int i = 0; i < m; i++) {
            int d = s[i] - '0';
            pw[i + 1] = pw[i] * 10 % MOD;
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
            cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0);
            sum[i + 1] = sum[i] + d;
        }
        int[] ans = new int[queries.Length];
        for (int k = 0; k < queries.Length; k++) {
            int l = queries[k][0], r = queries[k][1] + 1;
            long x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD + MOD) % MOD;
            ans[k] = (int)(x * (sum[r] - sum[l]) % MOD);
        }
        return ans;
    }
}