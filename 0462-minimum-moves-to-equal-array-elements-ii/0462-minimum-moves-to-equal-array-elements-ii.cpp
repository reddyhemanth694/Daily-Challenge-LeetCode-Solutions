/*
Brute Force

class Solution {
public:
    int minMoves2(vector<int>& nums) {
        long long best = LLONG_MAX;
        for (int x : nums) {
            long long cost = 0;
            for (int a : nums) cost += abs((long long)a - x);
            best = min(best, cost);
        }
        return (int)best;
    }
};
*/

/*
Better Approach

class Solution {
public:
    int minMoves2(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long median = nums[nums.size() / 2], moves = 0;
        for (int a : nums) moves += abs(a - median);
        return (int)moves;
    }
};
*/

class Solution {
public:
    int minMoves2(vector<int>& nums) {
        nth_element(nums.begin(), nums.begin() + nums.size() / 2, nums.end());
        long long median = nums[nums.size() / 2], moves = 0;
        for (int a : nums) moves += abs(a - median);
        return (int)moves;
    }
};