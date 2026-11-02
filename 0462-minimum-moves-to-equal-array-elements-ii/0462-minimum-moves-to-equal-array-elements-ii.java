/*
Brute Force

class Solution {
    public int minMoves2(int[] nums) {
        long best = Long.MAX_VALUE;
        for (int x : nums) {
            long cost = 0;
            for (int a : nums) cost += Math.abs((long) a - x);
            best = Math.min(best, cost);
        }
        return (int) best;
    }
}
*/

/*
Better Approach

class Solution {
    public int minMoves2(int[] nums) {
        Arrays.sort(nums);
        long median = nums[nums.length / 2], moves = 0;
        for (int a : nums) moves += Math.abs(a - median);
        return (int) moves;
    }
}
*/

class Solution {
    public int minMoves2(int[] nums) {
        long median = select(nums, nums.length / 2), moves = 0;
        for (int a : nums) moves += Math.abs(a - median);
        return (int) moves;
    }

    int select(int[] a, int k) {
        int lo = 0, hi = a.length - 1;
        while (true) {
            int pivot = a[lo + (int) (Math.random() * (hi - lo + 1))];
            int lt = lo, i = lo, gt = hi;
            while (i <= gt) {
                if (a[i] < pivot) swap(a, lt++, i++);
                else if (a[i] > pivot) swap(a, i, gt--);
                else i++;
            }
            if (k < lt) hi = lt - 1;
            else if (k > gt) lo = gt + 1;
            else return pivot;
        }
    }

    void swap(int[] a, int i, int j) {
        int t = a[i];
        a[i] = a[j];
        a[j] = t;
    }
}