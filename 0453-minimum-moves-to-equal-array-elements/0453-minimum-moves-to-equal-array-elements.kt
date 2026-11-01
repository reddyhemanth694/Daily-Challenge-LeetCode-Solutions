/*
Brute Force

class Solution {
    fun minMoves(nums: IntArray): Int {
        var moves = 0
        while (true) {
            var mx = 0
            var same = true
            for (i in 1 until nums.size) {
                if (nums[i] != nums[0]) same = false
                if (nums[i] > nums[mx]) mx = i
            }
            if (same) return moves
            for (i in nums.indices) if (i != mx) nums[i]++
            moves++
        }
    }
}
*/

/*
Better Approach

class Solution {
    fun minMoves(nums: IntArray): Int {
        nums.sort()
        var moves = 0L
        for (x in nums) moves += x.toLong() - nums[0]
        return moves.toInt()
    }
}
*/

class Solution {
    fun minMoves(nums: IntArray): Int {
        var mn = nums[0]
        for (x in nums) mn = minOf(mn, x)
        var moves = 0L
        for (x in nums) moves += x.toLong() - mn
        return moves.toInt()
    }
}