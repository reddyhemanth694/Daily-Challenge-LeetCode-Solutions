/*
Brute Force

class Solution {
    fun minOperations(nums: IntArray, x: Int, k: Int): Long {
        val n = nums.size
        fun windowCost(i: Int): Long {
            val w = nums.copyOfRange(i, i + x)
            w.sort()
            val med = w[x / 2].toLong()
            var cost = 0L
            for (v in w) cost += Math.abs(v - med)
            return cost
        }
        fun dfs(i: Int, j: Int): Long {
            if (j == 0) return 0
            if (n - i < j.toLong() * x) return Long.MAX_VALUE
            val skip = dfs(i + 1, j)
            val take = windowCost(i) + dfs(i + x, j - 1)
            return minOf(skip, take)
        }
        return dfs(0, k)
    }
}
*/

/*
Better Approach

class Solution {
    fun minOperations(nums: IntArray, x: Int, k: Int): Long {
        val n = nums.size
        val cost = LongArray(n - x + 1)
        for (i in 0..n - x) {
            val w = nums.copyOfRange(i, i + x)
            w.sort()
            val med = w[x / 2].toLong()
            for (v in w) cost[i] += Math.abs(v - med)
        }
        val inf = Long.MAX_VALUE / 4
        var prev = LongArray(n + 1)
        var cur = LongArray(n + 1)
        for (j in 1..k) {
            cur.fill(inf)
            for (i in x..n) cur[i] = minOf(cur[i - 1], prev[i - x] + cost[i - x])
            val t = prev
            prev = cur
            cur = t
        }
        return prev[n]
    }
}
*/

class Solution {
    fun minOperations(nums: IntArray, x: Int, k: Int): Long {
        val n = nums.size
        val vals = nums.distinct().sorted().toIntArray()
        val m = vals.size
        var top = 1
        while (top * 2 <= m) top *= 2
        val idx = IntArray(n) { vals.binarySearch(nums[it]) + 1 }
        val cnt = LongArray(m + 1)
        val sum = LongArray(m + 1)
        val cost = LongArray(n - x + 1)
        fun update(i: Int, d: Int) {
            var p = idx[i]
            while (p <= m) {
                cnt[p] += d.toLong()
                sum[p] += d.toLong() * nums[i]
                p += p and -p
            }
        }
        var total = 0L
        val half = (x + 1) / 2
        for (i in 0 until n) {
            update(i, 1)
            total += nums[i]
            if (i >= x) {
                update(i - x, -1)
                total -= nums[i - x]
            }
            if (i >= x - 1) {
                var pos = 0
                var need = half.toLong()
                var lowCnt = 0L
                var lowSum = 0L
                var step = top
                while (step > 0) {
                    if (pos + step <= m && cnt[pos + step] < need) {
                        pos += step
                        need -= cnt[pos]
                        lowCnt += cnt[pos]
                        lowSum += sum[pos]
                    }
                    step = step shr 1
                }
                val med = vals[pos].toLong()
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt)
            }
        }
        val inf = Long.MAX_VALUE / 4
        var prev = LongArray(n + 1)
        var cur = LongArray(n + 1)
        for (j in 1..k) {
            cur.fill(inf)
            for (i in x..n) cur[i] = minOf(cur[i - 1], prev[i - x] + cost[i - x])
            val t = prev
            prev = cur
            cur = t
        }
        return prev[n]
    }
}