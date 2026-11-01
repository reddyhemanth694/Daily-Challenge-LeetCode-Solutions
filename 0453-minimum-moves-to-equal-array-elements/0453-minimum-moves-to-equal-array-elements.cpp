/*
Brute Force

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int n = nums.size(), moves = 0;
        while (true) {
            int mx = 0;
            bool same = true;
            for (int i = 1; i < n; i++) {
                if (nums[i] != nums[0]) same = false;
                if (nums[i] > nums[mx]) mx = i;
            }
            if (same) return moves;
            for (int i = 0; i < n; i++)
                if (i != mx) nums[i]++;
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
        long long moves = 0;
        for (int x : nums) moves += (long long)x - nums[0];
        return (int)moves;
    }
};
*/

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int mn = *min_element(nums.begin(), nums.end());
        long long moves = 0;
        for (int x : nums) moves += (long long)x - mn;
        return (int)moves;
    }
};