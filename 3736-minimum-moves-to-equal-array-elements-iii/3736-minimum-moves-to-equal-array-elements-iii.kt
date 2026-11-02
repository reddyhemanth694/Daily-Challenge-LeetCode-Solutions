/*
Brute Force

class Solution {
    fun minMoves(nums: IntArray): Int {
        var moves = 0
        while (true) {
            var mn = 0
            var mx = 0
            for (i in 1 until nums.size) {
                if (nums[i] < nums[mn]) mn = i
                if (nums[i] > nums[mx]) mx = i
            }
            if (nums[mn] == nums[mx]) return moves
            nums[mn]++
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
        var moves = 0
        for (x in nums) moves += nums[nums.size - 1] - x
        return moves
    }
}
*/

class Solution {
    fun minMoves(nums: IntArray): Int {
        var mx = 0
        var sum = 0
        for (x in nums) {
            mx = maxOf(mx, x)
            sum += x
        }
        return mx * nums.size - sum
    }
}