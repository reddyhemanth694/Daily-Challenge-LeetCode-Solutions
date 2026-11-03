/*
Brute Force

import std.sort.*

class Solution {
    func minOperations(nums: Array<Int64>, x: Int64, k: Int64): Int64 {
        dfs(nums, x, 0, k)
    }

    func dfs(nums: Array<Int64>, x: Int64, i: Int64, j: Int64): Int64 {
        if (j == 0) {
            return 0
        }
        if (nums.size - i < j * x) {
            return 1000000000000000000
        }
        let skip = dfs(nums, x, i + 1, j)
        let take = windowCost(nums, x, i) + dfs(nums, x, i + x, j - 1)
        if (skip < take) {
            skip
        } else {
            take
        }
    }

    func windowCost(nums: Array<Int64>, x: Int64, i: Int64): Int64 {
        var w = Array<Int64>(x, {t => nums[i + t]})
        sort(w)
        let med = w[x / 2]
        var cost = 0
        for (v in w) {
            if (v > med) {
                cost += v - med
            } else {
                cost += med - v
            }
        }
        cost
    }
}
*/

/*
Better Approach

import std.sort.*

class Solution {
    func minOperations(nums: Array<Int64>, x: Int64, k: Int64): Int64 {
        let n = nums.size
        var cost = Array<Int64>(n - x + 1, {i => 0})
        for (i in 0..(n - x + 1)) {
            var w = Array<Int64>(x, {t => nums[i + t]})
            sort(w)
            let med = w[x / 2]
            for (v in w) {
                if (v > med) {
                    cost[i] += v - med
                } else {
                    cost[i] += med - v
                }
            }
        }
        let inf = 1000000000000000000
        var prev = Array<Int64>(n + 1, {i => 0})
        for (j in 0..k) {
            var cur = Array<Int64>(n + 1, {i => inf})
            for (i in x..=n) {
                let take = prev[i - x] + cost[i - x]
                if (cur[i - 1] < take) {
                    cur[i] = cur[i - 1]
                } else {
                    cur[i] = take
                }
            }
            prev = cur
        }
        prev[n]
    }
}
*/

import std.sort.*

class Solution {
    func minOperations(nums: Array<Int64>, x: Int64, k: Int64): Int64 {
        let n = nums.size
        var vals = Array<Int64>(n, {i => nums[i]})
        sort(vals)
        var m = 0
        for (i in 0..n) {
            if (i == 0 || vals[i] != vals[i - 1]) {
                vals[m] = vals[i]
                m += 1
            }
        }
        var idx = Array<Int64>(n, {i => 0})
        for (i in 0..n) {
            var lo = 0
            var hi = m
            while (lo < hi) {
                let mid = (lo + hi) / 2
                if (vals[mid] < nums[i]) {
                    lo = mid + 1
                } else {
                    hi = mid
                }
            }
            idx[i] = lo + 1
        }
        var top = 1
        while (top * 2 <= m) {
            top *= 2
        }
        var cnt = Array<Int64>(m + 1, {i => 0})
        var sum = Array<Int64>(m + 1, {i => 0})
        var cost = Array<Int64>(n - x + 1, {i => 0})
        var total = 0
        let half = (x + 1) / 2
        for (i in 0..n) {
            var p = idx[i]
            while (p <= m) {
                cnt[p] += 1
                sum[p] += nums[i]
                p += p & (-p)
            }
            total += nums[i]
            if (i >= x) {
                p = idx[i - x]
                while (p <= m) {
                    cnt[p] -= 1
                    sum[p] -= nums[i - x]
                    p += p & (-p)
                }
                total -= nums[i - x]
            }
            if (i >= x - 1) {
                var pos = 0
                var need = half
                var lowCnt = 0
                var lowSum = 0
                var step = top
                while (step > 0) {
                    if (pos + step <= m && cnt[pos + step] < need) {
                        pos += step
                        need -= cnt[pos]
                        lowCnt += cnt[pos]
                        lowSum += sum[pos]
                    }
                    step /= 2
                }
                let med = vals[pos]
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt)
            }
        }
        let inf = 1000000000000000000
        var prev = Array<Int64>(n + 1, {i => 0})
        for (j in 0..k) {
            var cur = Array<Int64>(n + 1, {i => inf})
            for (i in x..=n) {
                let take = prev[i - x] + cost[i - x]
                if (cur[i - 1] < take) {
                    cur[i] = cur[i - 1]
                } else {
                    cur[i] = take
                }
            }
            prev = cur
        }
        prev[n]
    }
}