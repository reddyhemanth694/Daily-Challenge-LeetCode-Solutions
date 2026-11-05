/*
Brute Force

class Solution {
    func findTheDistanceValue(arr1: Array<Int64>, arr2: Array<Int64>, d: Int64): Int64 {
        var ans = 0
        for (a in arr1) {
            var ok = true
            for (b in arr2) {
                if (a - b <= d && b - a <= d) {
                    ok = false
                    break
                }
            }
            if (ok) {
                ans += 1
            }
        }
        ans
    }
}
*/

/*
Better Approach

import std.sort.*

class Solution {
    func findTheDistanceValue(arr1: Array<Int64>, arr2: Array<Int64>, d: Int64): Int64 {
        let m = arr2.size
        var b = Array<Int64>(m, {i => arr2[i]})
        sort(b)
        var ans = 0
        for (a in arr1) {
            var lo = 0
            var hi = m
            while (lo < hi) {
                let mid = (lo + hi) / 2
                if (b[mid] < a - d) {
                    lo = mid + 1
                } else {
                    hi = mid
                }
            }
            if (lo == m || b[lo] > a + d) {
                ans += 1
            }
        }
        ans
    }
}
*/

class Solution {
    func findTheDistanceValue(arr1: Array<Int64>, arr2: Array<Int64>, d: Int64): Int64 {
        var pre = Array<Int64>(2202, {i => 0})
        for (v in arr2) {
            pre[v + 1101] += 1
        }
        for (i in 1..2202) {
            pre[i] += pre[i - 1]
        }
        var ans = 0
        for (a in arr1) {
            if (pre[a + d + 1101] == pre[a - d + 1100]) {
                ans += 1
            }
        }
        ans
    }
}