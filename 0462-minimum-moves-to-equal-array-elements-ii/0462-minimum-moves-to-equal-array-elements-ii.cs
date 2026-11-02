/*
Brute Force

public class Solution {
    public int MinMoves2(int[] nums) {
        long best = long.MaxValue;
        foreach (int x in nums) {
            long cost = 0;
            foreach (int a in nums) cost += Math.Abs((long)a - x);
            best = Math.Min(best, cost);
        }
        return (int)best;
    }
}
*/

/*
Better Approach

public class Solution {
    public int MinMoves2(int[] nums) {
        Array.Sort(nums);
        long median = nums[nums.Length / 2], moves = 0;
        foreach (int a in nums) moves += Math.Abs(a - median);
        return (int)moves;
    }
}
*/

public class Solution {
    public int MinMoves2(int[] nums) {
        Random rnd = new Random();
        int k = nums.Length / 2, lo = 0, hi = nums.Length - 1;
        long median = 0;
        while (true) {
            int pivot = nums[rnd.Next(lo, hi + 1)];
            int lt = lo, i = lo, gt = hi;
            while (i <= gt) {
                if (nums[i] < pivot) {
                    int t = nums[lt];
                    nums[lt++] = nums[i];
                    nums[i++] = t;
                } else if (nums[i] > pivot) {
                    int t = nums[gt];
                    nums[gt--] = nums[i];
                    nums[i] = t;
                } else {
                    i++;
                }
            }
            if (k < lt) hi = lt - 1;
            else if (k > gt) lo = gt + 1;
            else {
                median = pivot;
                break;
            }
        }
        long moves = 0;
        foreach (int a in nums) moves += Math.Abs(a - median);
        return (int)moves;
    }
}