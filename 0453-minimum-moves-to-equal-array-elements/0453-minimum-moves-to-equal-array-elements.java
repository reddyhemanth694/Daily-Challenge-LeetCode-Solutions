/*
Brute Force

class Solution {
    public int minMoves(int[] nums) {
        int n = nums.length, moves = 0;
        while (true) {
            int mx = 0;
            boolean same = true;
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
}
*/

/*
Better Approach

class Solution {
    public int minMoves(int[] nums) {
        Arrays.sort(nums);
        long moves = 0;
        for (int x : nums) moves += (long) x - nums[0];
        return (int) moves;
    }
}
*/

class Solution {
    public int minMoves(int[] nums) {
        int mn = Integer.MAX_VALUE;
        for (int x : nums) mn = Math.min(mn, x);
        long moves = 0;
        for (int x : nums) moves += (long) x - mn;
        return (int) moves;
    }
}