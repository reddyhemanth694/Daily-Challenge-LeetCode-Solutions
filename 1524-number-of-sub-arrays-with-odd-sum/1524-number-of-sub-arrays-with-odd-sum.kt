/*
Brute Force

class Solution {
    fun numOfSubarrays(arr: IntArray): Int {
        val mod = 1_000_000_007
        val n = arr.size
        var ans = 0
        for (i in 0 until n) {
            for (j in i until n) {
                var sum = 0
                for (k in i..j) sum += arr[k]
                if (sum % 2 == 1) ans = (ans + 1) % mod
            }
        }
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    fun numOfSubarrays(arr: IntArray): Int {
        val mod = 1_000_000_007
        val n = arr.size
        var ans = 0
        for (i in 0 until n) {
            var sum = 0
            for (j in i until n) {
                sum += arr[j]
                if (sum % 2 == 1) ans = (ans + 1) % mod
            }
        }
        return ans
    }
}
*/

class Solution {
    fun numOfSubarrays(arr: IntArray): Int {
        val mod = 1_000_000_007
        var odd = 0
        var even = 1
        var sum = 0
        var ans = 0
        for (x in arr) {
            sum += x
            if (sum % 2 == 1) {
                ans = (ans + even) % mod
                odd++
            } else {
                ans = (ans + odd) % mod
                even++
            }
        }
        return ans
    }
}