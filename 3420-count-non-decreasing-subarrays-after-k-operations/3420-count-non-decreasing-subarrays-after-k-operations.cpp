/*
Brute Force

class Solution {
public:
    long long countNonDecreasingSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        long long ans = 0;
        for (int l = 0; l < n; l++) {
            long long cost = 0;
            int mx = 0;
            for (int r = l; r < n; r++) {
                mx = max(mx, nums[r]);
                cost += mx - nums[r];
                if (cost > k) break;
                ans++;
            }
        }
        return ans;
    }
};
*/

/*
Better Approach

class Solution {
public:
    long long countNonDecreasingSubarrays(vector<int>& nums, int k) {
        int n = nums.size(), lg = 1;
        while ((1 << lg) <= n) lg++;
        vector<long long> pre(n + 1, 0);
        for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
        vector<vector<int>> up(lg, vector<int>(n + 1, n));
        vector<vector<long long>> sum(lg, vector<long long>(n + 1, 0));
        vector<int> st;
        for (int i = n - 1; i >= 0; i--) {
            while (!st.empty() && nums[st.back()] <= nums[i]) st.pop_back();
            int nx = st.empty() ? n : st.back();
            st.push_back(i);
            up[0][i] = nx;
            sum[0][i] = (long long)nums[i] * (nx - i) - (pre[nx] - pre[i]);
        }
        for (int j = 1; j < lg; j++)
            for (int i = 0; i <= n; i++) {
                up[j][i] = up[j - 1][up[j - 1][i]];
                sum[j][i] = sum[j - 1][i] + sum[j - 1][up[j - 1][i]];
            }
        long long ans = 0;
        for (int l = 0; l < n; l++) {
            int cur = l;
            long long acc = 0;
            for (int j = lg - 1; j >= 0; j--) {
                if (cur < n && acc + sum[j][cur] <= k) {
                    acc += sum[j][cur];
                    cur = up[j][cur];
                }
            }
            if (cur == n) {
                ans += n - l;
                continue;
            }
            int lo = cur, hi = up[0][cur] - 1;
            while (lo < hi) {
                int mid = (lo + hi + 1) / 2;
                if (acc + (long long)nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) lo = mid;
                else hi = mid - 1;
            }
            ans += lo - l + 1;
        }
        return ans;
    }
};
*/

class Solution {
public:
    long long countNonDecreasingSubarrays(vector<int>& nums, int k) {
        int n = nums.size(), head = n, tail = n, r = n - 1;
        vector<int> dq(n);
        long long ans = 0, cost = 0;
        for (int l = n - 1; l >= 0; l--) {
            while (head < tail && nums[dq[head]] <= nums[l]) {
                int i = dq[head++];
                int end = head < tail ? dq[head] : r + 1;
                cost += (long long)(nums[l] - nums[i]) * (end - i);
            }
            dq[--head] = l;
            while (cost > k) {
                cost -= nums[dq[tail - 1]] - nums[r];
                if (dq[tail - 1] == r) tail--;
                r--;
            }
            ans += r - l + 1;
        }
        return ans;
    }
};