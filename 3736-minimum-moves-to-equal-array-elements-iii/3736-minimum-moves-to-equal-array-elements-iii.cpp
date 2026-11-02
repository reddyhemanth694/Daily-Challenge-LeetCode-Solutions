/*
Brute Force

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int n = nums.size(), moves = 0;
        while (true) {
            int mn = 0, mx = 0;
            for (int i = 1; i < n; i++) {
                if (nums[i] < nums[mn]) mn = i;
                if (nums[i] > nums[mx]) mx = i;
            }
            if (nums[mn] == nums[mx]) return moves;
            nums[mn]++;
            moves++;
        }
    }
};
*/

/*
Better Approach

class Solution {
public:
    int minMoves(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int moves = 0;
        for (int x : nums) moves += nums.back() - x;
        return moves;
    }
};
*/

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int mx = 0, sum = 0;
        for (int x : nums) {
            mx = max(mx, x);
            sum += x;
        }
        return mx * (int)nums.size() - sum;
    }
};