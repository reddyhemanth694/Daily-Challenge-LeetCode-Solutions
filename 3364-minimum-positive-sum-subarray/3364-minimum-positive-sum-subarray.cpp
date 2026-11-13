/*
Brute Force

class Solution {
public:
    int minimumSumSubarray(vector<int>& nums, int l, int r) {
        int n = nums.size(), ans = INT_MAX;
        for (int i = 0; i < n; i++) {
            for (int len = l; len <= r && i + len <= n; len++) {
                int sum = 0;
                for (int j = i; j < i + len; j++) sum += nums[j];
                if (sum > 0) ans = min(ans, sum);
            }
        }
        return ans == INT_MAX ? -1 : ans;
    }
};
*/

/*
Better Approach

class Solution {
public:
    int minimumSumSubarray(vector<int>& nums, int l, int r) {
        int n = nums.size(), ans = INT_MAX;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n && j - i + 1 <= r; j++) {
                sum += nums[j];
                if (j - i + 1 >= l && sum > 0) ans = min(ans, sum);
            }
        }
        return ans == INT_MAX ? -1 : ans;
    }
};
*/

class Solution {
public:
    int minimumSumSubarray(vector<int>& nums, int l, int r) {
        int n = nums.size(), ans = INT_MAX;
        vector<int> pre(n + 1, 0);
        for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
        multiset<int> win;
        for (int j = l; j <= n; j++) {
            win.insert(pre[j - l]);
            if (j - r - 1 >= 0) win.erase(win.find(pre[j - r - 1]));
            auto it = win.lower_bound(pre[j]);
            if (it != win.begin()) ans = min(ans, pre[j] - *prev(it));
        }
        return ans == INT_MAX ? -1 : ans;
    }
};