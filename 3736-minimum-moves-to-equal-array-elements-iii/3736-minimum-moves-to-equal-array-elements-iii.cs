/*
Brute Force

public class Solution {
    public int MinMoves(int[] nums) {
        int n = nums.Length, moves = 0;
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
}
*/

/*
Better Approach

public class Solution {
    public int MinMoves(int[] nums) {
        Array.Sort(nums);
        int moves = 0;
        foreach (int x in nums) moves += nums[nums.Length - 1] - x;
        return moves;
    }
}
*/

public class Solution {
    public int MinMoves(int[] nums) {
        int mx = 0, sum = 0;
        foreach (int x in nums) {
            mx = Math.Max(mx, x);
            sum += x;
        }
        return mx * nums.Length - sum;
    }
}