/*
Brute Force

public class Solution {
    public int MinMoves(int[] nums) {
        int n = nums.Length, moves = 0;
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
}
*/

/*
Better Approach

public class Solution {
    public int MinMoves(int[] nums) {
        Array.Sort(nums);
        long moves = 0;
        foreach (int x in nums) moves += (long)x - nums[0];
        return (int)moves;
    }
}
*/

public class Solution {
    public int MinMoves(int[] nums) {
        int mn = int.MaxValue;
        foreach (int x in nums) mn = Math.Min(mn, x);
        long moves = 0;
        foreach (int x in nums) moves += (long)x - mn;
        return (int)moves;
    }
}