/*
Brute Force

class Solution {
public:
    int findTheDistanceValue(vector<int>& arr1, vector<int>& arr2, int d) {
        int ans = 0;
        for (int a : arr1) {
            bool ok = true;
            for (int b : arr2) {
                if (abs(a - b) <= d) {
                    ok = false;
                    break;
                }
            }
            if (ok) ans++;
        }
        return ans;
    }
};
*/

/*
Better Approach

class Solution {
public:
    int findTheDistanceValue(vector<int>& arr1, vector<int>& arr2, int d) {
        sort(arr2.begin(), arr2.end());
        int ans = 0;
        for (int a : arr1) {
            auto it = lower_bound(arr2.begin(), arr2.end(), a - d);
            if (it == arr2.end() || *it > a + d) ans++;
        }
        return ans;
    }
};
*/

class Solution {
public:
    int findTheDistanceValue(vector<int>& arr1, vector<int>& arr2, int d) {
        vector<int> pre(2202, 0);
        for (int v : arr2) pre[v + 1101]++;
        for (int i = 1; i < 2202; i++) pre[i] += pre[i - 1];
        int ans = 0;
        for (int a : arr1)
            if (pre[a + d + 1101] == pre[a - d + 1100]) ans++;
        return ans;
    }
};