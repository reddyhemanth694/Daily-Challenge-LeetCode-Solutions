/*
Brute Force

class Solution {
public:
    vector<int> countServers(int n, vector<vector<int>>& logs, int x, vector<int>& queries) {
        vector<int> ans;
        for (int q : queries) {
            vector<bool> seen(n + 1, false);
            int cnt = 0;
            for (auto& lg : logs) {
                if (lg[1] >= q - x && lg[1] <= q && !seen[lg[0]]) {
                    seen[lg[0]] = true;
                    cnt++;
                }
            }
            ans.push_back(n - cnt);
        }
        return ans;
    }
};
*/

/*
Better Approach

class Solution {
public:
    vector<int> countServers(int n, vector<vector<int>>& logs, int x, vector<int>& queries) {
        sort(logs.begin(), logs.end(), [](const vector<int>& a, const vector<int>& b) { return a[1] < b[1]; });
        int m = logs.size(), k = queries.size();
        vector<int> times(m), stamp(n + 1, -1), ans(k);
        for (int j = 0; j < m; j++) times[j] = logs[j][1];
        for (int i = 0; i < k; i++) {
            int j = lower_bound(times.begin(), times.end(), queries[i] - x) - times.begin();
            int cnt = 0;
            for (; j < m && times[j] <= queries[i]; j++) {
                if (stamp[logs[j][0]] != i) {
                    stamp[logs[j][0]] = i;
                    cnt++;
                }
            }
            ans[i] = n - cnt;
        }
        return ans;
    }
};
*/

class Solution {
public:
    vector<int> countServers(int n, vector<vector<int>>& logs, int x, vector<int>& queries) {
        sort(logs.begin(), logs.end(), [](const vector<int>& a, const vector<int>& b) { return a[1] < b[1]; });
        int m = logs.size(), k = queries.size();
        vector<int> idx(k), cnt(n + 1, 0), ans(k);
        iota(idx.begin(), idx.end(), 0);
        sort(idx.begin(), idx.end(), [&](int a, int b) { return queries[a] < queries[b]; });
        int l = 0, r = 0, distinct = 0;
        for (int i : idx) {
            int q = queries[i];
            while (r < m && logs[r][1] <= q)
                if (cnt[logs[r++][0]]++ == 0) distinct++;
            while (l < r && logs[l][1] < q - x)
                if (--cnt[logs[l++][0]] == 0) distinct--;
            ans[i] = n - distinct;
        }
        return ans;
    }
};