/*
Brute Force

class Solution {
public:
    vector<int> sumAndMultiply(string s, vector<vector<int>>& queries) {
        const long long MOD = 1e9 + 7;
        vector<int> ans;
        for (auto& q : queries) {
            long long x = 0, sum = 0;
            for (int i = q[0]; i <= q[1]; i++) {
                int d = s[i] - '0';
                if (d != 0) {
                    x = (x * 10 + d) % MOD;
                    sum += d;
                }
            }
            ans.push_back((int)(x * sum % MOD));
        }
        return ans;
    }
};
*/

/*
Better Approach

class Solution {
public:
    const long long MOD = 1e9 + 7;

    long long power(long long b, int e) {
        long long r = 1;
        while (e > 0) {
            if (e & 1) r = r * b % MOD;
            b = b * b % MOD;
            e >>= 1;
        }
        return r;
    }

    vector<int> sumAndMultiply(string s, vector<vector<int>>& queries) {
        int m = s.size();
        vector<long long> pre(m + 1, 0);
        vector<int> cnt(m + 1, 0), sum(m + 1, 0);
        for (int i = 0; i < m; i++) {
            int d = s[i] - '0';
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
            cnt[i + 1] = cnt[i] + (d != 0);
            sum[i + 1] = sum[i] + d;
        }
        vector<int> ans;
        for (auto& q : queries) {
            int l = q[0], r = q[1] + 1;
            long long x = ((pre[r] - pre[l] * power(10, cnt[r] - cnt[l])) % MOD + MOD) % MOD;
            ans.push_back((int)(x * (sum[r] - sum[l]) % MOD));
        }
        return ans;
    }
};
*/

class Solution {
public:
    vector<int> sumAndMultiply(string s, vector<vector<int>>& queries) {
        const long long MOD = 1e9 + 7;
        int m = s.size();
        vector<long long> pre(m + 1, 0), pw(m + 1, 1);
        vector<int> cnt(m + 1, 0), sum(m + 1, 0);
        for (int i = 0; i < m; i++) {
            int d = s[i] - '0';
            pw[i + 1] = pw[i] * 10 % MOD;
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
            cnt[i + 1] = cnt[i] + (d != 0);
            sum[i + 1] = sum[i] + d;
        }
        vector<int> ans;
        for (auto& q : queries) {
            int l = q[0], r = q[1] + 1;
            long long x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD + MOD) % MOD;
            ans.push_back((int)(x * (sum[r] - sum[l]) % MOD));
        }
        return ans;
    }
};