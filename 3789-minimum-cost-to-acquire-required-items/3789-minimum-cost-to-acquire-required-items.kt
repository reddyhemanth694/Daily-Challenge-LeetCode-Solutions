/*
Brute Force

class Solution {
    fun minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long {
        var best = Long.MAX_VALUE
        for (k in 0L..maxOf(need1, need2)) {
            val cost = k * costBoth + maxOf(0L, need1 - k) * cost1 + maxOf(0L, need2 - k) * cost2
            best = minOf(best, cost)
        }
        return best
    }
}
*/

/*
Better Approach

class Solution {
    fun minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long {
        fun total(k: Long): Long = k * costBoth + maxOf(0L, need1 - k) * cost1 + maxOf(0L, need2 - k) * cost2
        var lo = 0L
        var hi = maxOf(need1, need2).toLong()
        while (lo < hi) {
            val mid = (lo + hi) / 2
            if (total(mid) <= total(mid + 1)) hi = mid else lo = mid + 1
        }
        return total(lo)
    }
}
*/

class Solution {
    fun minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long {
        val both = minOf(need1, need2).toLong()
        return both * minOf(costBoth, cost1 + cost2) + (need1 - both) * minOf(cost1, costBoth) + (need2 - both) * minOf(cost2, costBoth)
    }
}