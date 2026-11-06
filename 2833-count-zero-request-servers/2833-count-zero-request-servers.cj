/*
Brute Force

class Solution {
    func countServers(n: Int64, logs: Array<Array<Int64>>, x: Int64, queries: Array<Int64>): Array<Int64> {
        var ans = Array<Int64>(queries.size, {i => 0})
        for (i in 0..queries.size) {
            let q = queries[i]
            var seen = Array<Bool>(n + 1, {j => false})
            var cnt = 0
            for (lg in logs) {
                if (lg[1] >= q - x && lg[1] <= q && !seen[lg[0]]) {
                    seen[lg[0]] = true
                    cnt += 1
                }
            }
            ans[i] = n - cnt
        }
        ans
    }
}
*/

/*
Better Approach

import std.sort.*

class Solution {
    func countServers(n: Int64, logs: Array<Array<Int64>>, x: Int64, queries: Array<Int64>): Array<Int64> {
        let m = logs.size
        var keys = Array<Int64>(m, {i => logs[i][1] * 131072 + logs[i][0]})
        sort(keys)
        var stamp = Array<Int64>(n + 1, {i => -1})
        var ans = Array<Int64>(queries.size, {i => 0})
        for (i in 0..queries.size) {
            let q = queries[i]
            var lo = 0
            var hi = m
            while (lo < hi) {
                let mid = (lo + hi) / 2
                if (keys[mid] / 131072 < q - x) {
                    lo = mid + 1
                } else {
                    hi = mid
                }
            }
            var cnt = 0
            var j = lo
            while (j < m && keys[j] / 131072 <= q) {
                let s = keys[j] % 131072
                if (stamp[s] != i) {
                    stamp[s] = i
                    cnt += 1
                }
                j += 1
            }
            ans[i] = n - cnt
        }
        ans
    }
}
*/

import std.sort.*

class Solution {
    func countServers(n: Int64, logs: Array<Array<Int64>>, x: Int64, queries: Array<Int64>): Array<Int64> {
        let m = logs.size
        var keys = Array<Int64>(m, {i => logs[i][1] * 131072 + logs[i][0]})
        sort(keys)
        var order = Array<Int64>(queries.size, {i => queries[i] * 131072 + i})
        sort(order)
        var cnt = Array<Int64>(n + 1, {i => 0})
        var ans = Array<Int64>(queries.size, {i => 0})
        var distinct = 0
        var l = 0
        var r = 0
        for (key in order) {
            let q = key / 131072
            let idx = key % 131072
            while (r < m && keys[r] / 131072 <= q) {
                let s = keys[r] % 131072
                if (cnt[s] == 0) {
                    distinct += 1
                }
                cnt[s] += 1
                r += 1
            }
            while (l < r && keys[l] / 131072 < q - x) {
                let s = keys[l] % 131072
                cnt[s] -= 1
                if (cnt[s] == 0) {
                    distinct -= 1
                }
                l += 1
            }
            ans[idx] = n - distinct
        }
        ans
    }
}