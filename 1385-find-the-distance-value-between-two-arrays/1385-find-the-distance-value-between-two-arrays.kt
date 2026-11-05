/*
Brute Force

class Solution {
    fun findTheDistanceValue(arr1: IntArray, arr2: IntArray, d: Int): Int {
        var ans = 0
        for (a in arr1)
            if (arr2.all { Math.abs(a - it) > d }) ans++
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    fun findTheDistanceValue(arr1: IntArray, arr2: IntArray, d: Int): Int {
        arr2.sort()
        var ans = 0
        for (a in arr1) {
            var lo = 0
            var hi = arr2.size
            while (lo < hi) {
                val mid = (lo + hi) / 2
                if (arr2[mid] < a - d) lo = mid + 1 else hi = mid
            }
            if (lo == arr2.size || arr2[lo] > a + d) ans++
        }
        return ans
    }
}
*/

class Solution {
    fun findTheDistanceValue(arr1: IntArray, arr2: IntArray, d: Int): Int {
        val pre = IntArray(2202)
        for (v in arr2) pre[v + 1101]++
        for (i in 1 until 2202) pre[i] += pre[i - 1]
        var ans = 0
        for (a in arr1)
            if (pre[a + d + 1101] == pre[a - d + 1100]) ans++
        return ans
    }
}