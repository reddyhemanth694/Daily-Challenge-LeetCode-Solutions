/*
Brute Force

class Solution {
    fun countServers(n: Int, logs: Array<IntArray>, x: Int, queries: IntArray): IntArray {
        return IntArray(queries.size) { i ->
            val q = queries[i]
            val seen = BooleanArray(n + 1)
            var cnt = 0
            for (lg in logs) {
                if (lg[1] >= q - x && lg[1] <= q && !seen[lg[0]]) {
                    seen[lg[0]] = true
                    cnt++
                }
            }
            n - cnt
        }
    }
}
*/

/*
Better Approach

class Solution {
    fun countServers(n: Int, logs: Array<IntArray>, x: Int, queries: IntArray): IntArray {
        logs.sortBy { it[1] }
        val m = logs.size
        val stamp = IntArray(n + 1) { -1 }
        return IntArray(queries.size) { i ->
            val q = queries[i]
            var lo = 0
            var hi = m
            while (lo < hi) {
                val mid = (lo + hi) / 2
                if (logs[mid][1] < q - x) lo = mid + 1 else hi = mid
            }
            var cnt = 0
            var j = lo
            while (j < m && logs[j][1] <= q) {
                if (stamp[logs[j][0]] != i) {
                    stamp[logs[j][0]] = i
                    cnt++
                }
                j++
            }
            n - cnt
        }
    }
}
*/

class Solution {
    fun countServers(n: Int, logs: Array<IntArray>, x: Int, queries: IntArray): IntArray {
        logs.sortBy { it[1] }
        val m = logs.size
        val idx = queries.indices.sortedBy { queries[it] }
        val cnt = IntArray(n + 1)
        val ans = IntArray(queries.size)
        var l = 0
        var r = 0
        var distinct = 0
        for (i in idx) {
            val q = queries[i]
            while (r < m && logs[r][1] <= q) {
                if (cnt[logs[r][0]]++ == 0) distinct++
                r++
            }
            while (l < r && logs[l][1] < q - x) {
                if (--cnt[logs[l][0]] == 0) distinct--
                l++
            }
            ans[i] = n - distinct
        }
        return ans
    }
}