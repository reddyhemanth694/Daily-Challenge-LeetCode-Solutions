/*
Brute Force

public class Solution {
    public int LongestMonotonicSubarray(int[] nums) {
        int n = nums.Length, res = 1;
        for (int i = 0; i < n; i++) {
            int inc = 1, dec = 1;
            while (i + inc < n && nums[i + inc] > nums[i + inc - 1]) inc++;
            while (i + dec < n && nums[i + dec] < nums[i + dec - 1]) dec++;
            res = Math.Max(res, Math.Max(inc, dec));
        }
        return res;
    }
}
*/

/*
Better Approach

public class Solution {
    public int LongestMonotonicSubarray(int[] nums) {
        int res = 1, len = 1;
        for (int i = 1; i < nums.Length; i++) {
            len = nums[i] > nums[i - 1] ? len + 1 : 1;
            res = Math.Max(res, len);
        }
        len = 1;
        for (int i = 1; i < nums.Length; i++) {
            len = nums[i] < nums[i - 1] ? len + 1 : 1;
            res = Math.Max(res, len);
        }
        return res;
    }
}
*/

public class Solution {
    public int LongestMonotonicSubarray(int[] nums) {
        int res = 1, inc = 1, dec = 1;
        for (int i = 1; i < nums.Length; i++) {
            inc = nums[i] > nums[i - 1] ? inc + 1 : 1;
            dec = nums[i] < nums[i - 1] ? dec + 1 : 1;
            res = Math.Max(res, Math.Max(inc, dec));
        }
        return res;
    }
}