/*
Brute Force

class Solution {
    fun minMoves2(nums: IntArray): Int {
        var best = Long.MAX_VALUE
        for (x in nums) {
            var cost = 0L
            for (a in nums) cost += Math.abs(a.toLong() - x)
            best = minOf(best, cost)
        }
        return best.toInt()
    }
}
*/

/*
Better Approach

class Solution {
    fun minMoves2(nums: IntArray): Int {
        nums.sort()
        val median = nums[nums.size / 2].toLong()
        var moves = 0L
        for (a in nums) moves += Math.abs(a - median)
        return moves.toInt()
    }
}
*/

class Solution {
    fun minMoves2(nums: IntArray): Int {
        val k = nums.size / 2
        var lo = 0
        var hi = nums.size - 1
        var median = 0L
        while (true) {
            val pivot = nums[(lo..hi).random()]
            var lt = lo
            var i = lo
            var gt = hi
            while (i <= gt) {
                if (nums[i] < pivot) {
                    val t = nums[lt]
                    nums[lt++] = nums[i]
                    nums[i++] = t
                } else if (nums[i] > pivot) {
                    val t = nums[gt]
                    nums[gt--] = nums[i]
                    nums[i] = t
                } else {
                    i++
                }
            }
            if (k < lt) hi = lt - 1
            else if (k > gt) lo = gt + 1
            else {
                median = pivot.toLong()
                break
            }
        }
        var moves = 0L
        for (a in nums) moves += Math.abs(a - median)
        return moves.toInt()
    }
}