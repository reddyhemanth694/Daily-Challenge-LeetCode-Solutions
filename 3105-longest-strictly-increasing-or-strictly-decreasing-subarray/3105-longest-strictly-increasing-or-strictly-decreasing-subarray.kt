/*
Brute Force

class Solution {
    fun longestMonotonicSubarray(nums: IntArray): Int {
        val n = nums.size
        var res = 1
        for (i in 0 until n) {
            var inc = 1
            var dec = 1
            while (i + inc < n && nums[i + inc] > nums[i + inc - 1]) inc++
            while (i + dec < n && nums[i + dec] < nums[i + dec - 1]) dec++
            res = maxOf(res, inc, dec)
        }
        return res
    }
}
*/

/*
Better Approach

class Solution {
    fun longestMonotonicSubarray(nums: IntArray): Int {
        var res = 1
        var len = 1
        for (i in 1 until nums.size) {
            len = if (nums[i] > nums[i - 1]) len + 1 else 1
            res = maxOf(res, len)
        }
        len = 1
        for (i in 1 until nums.size) {
            len = if (nums[i] < nums[i - 1]) len + 1 else 1
            res = maxOf(res, len)
        }
        return res
    }
}
*/

class Solution {
    fun longestMonotonicSubarray(nums: IntArray): Int {
        var res = 1
        var inc = 1
        var dec = 1
        for (i in 1 until nums.size) {
            inc = if (nums[i] > nums[i - 1]) inc + 1 else 1
            dec = if (nums[i] < nums[i - 1]) dec + 1 else 1
            res = maxOf(res, inc, dec)
        }
        return res
    }
}