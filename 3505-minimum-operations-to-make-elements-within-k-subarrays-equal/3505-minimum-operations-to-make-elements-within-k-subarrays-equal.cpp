/*
Brute Force

class Solution {
public:
    int n, x;
    vector<int> a;

    long long windowCost(int i) {
        vector<int> w(a.begin() + i, a.begin() + i + x);
        sort(w.begin(), w.end());
        long long med = w[x / 2], cost = 0;
        for (int v : w) cost += abs(v - med);
        return cost;
    }

    long long dfs(int i, int j) {
        if (j == 0) return 0;
        if (n - i < (long long)j * x) return LLONG_MAX;
        long long skip = dfs(i + 1, j);
        long long take = windowCost(i) + dfs(i + x, j - 1);
        return min(skip, take);
    }

    long long minOperations(vector<int>& nums, int x, int k) {
        a = nums;
        n = nums.size();
        this->x = x;
        return dfs(0, k);
    }
};
*/

/*
Better Approach

class Solution {
public:
    long long minOperations(vector<int>& nums, int x, int k) {
        int n = nums.size();
        vector<long long> cost(n - x + 1, 0);
        for (int i = 0; i + x <= n; i++) {
            vector<int> w(nums.begin() + i, nums.begin() + i + x);
            sort(w.begin(), w.end());
            long long med = w[x / 2];
            for (int v : w) cost[i] += abs(v - med);
        }
        const long long INF = LLONG_MAX / 4;
        vector<long long> prev(n + 1, 0), cur(n + 1);
        for (int j = 1; j <= k; j++) {
            fill(cur.begin(), cur.end(), INF);
            for (int i = x; i <= n; i++) cur[i] = min(cur[i - 1], prev[i - x] + cost[i - x]);
            swap(prev, cur);
        }
        return prev[n];
    }
};
*/

class Solution {
public:
    long long minOperations(vector<int>& nums, int x, int k) {
        int n = nums.size();
        vector<int> vals(nums);
        sort(vals.begin(), vals.end());
        vals.erase(unique(vals.begin(), vals.end()), vals.end());
        int m = vals.size(), top = 1;
        while (top * 2 <= m) top *= 2;
        vector<int> idx(n);
        for (int i = 0; i < n; i++) idx[i] = lower_bound(vals.begin(), vals.end(), nums[i]) - vals.begin() + 1;
        vector<long long> cnt(m + 1, 0), sum(m + 1, 0), cost(n - x + 1, 0);
        auto update = [&](int i, int d) {
            for (int p = idx[i]; p <= m; p += p & -p) {
                cnt[p] += d;
                sum[p] += (long long)d * nums[i];
            }
        };
        long long total = 0;
        int half = (x + 1) / 2;
        for (int i = 0; i < n; i++) {
            update(i, 1);
            total += nums[i];
            if (i >= x) {
                update(i - x, -1);
                total -= nums[i - x];
            }
            if (i >= x - 1) {
                int pos = 0;
                long long need = half, lowCnt = 0, lowSum = 0;
                for (int step = top; step > 0; step >>= 1) {
                    if (pos + step <= m && cnt[pos + step] < need) {
                        pos += step;
                        need -= cnt[pos];
                        lowCnt += cnt[pos];
                        lowSum += sum[pos];
                    }
                }
                long long med = vals[pos];
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
            }
        }
        const long long INF = LLONG_MAX / 4;
        vector<long long> prev(n + 1, 0), cur(n + 1);
        for (int j = 1; j <= k; j++) {
            fill(cur.begin(), cur.end(), INF);
            for (int i = x; i <= n; i++) cur[i] = min(cur[i - 1], prev[i - x] + cost[i - x]);
            swap(prev, cur);
        }
        return prev[n];
    }
};