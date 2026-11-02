/*
Brute Force

class Solution {
    func minMoves(_ nums: [Int]) -> Int {
        var nums = nums
        var moves = 0
        while true {
            var mn = 0, mx = 0
            for i in 1..<nums.count {
                if nums[i] < nums[mn] { mn = i }
                if nums[i] > nums[mx] { mx = i }
            }
            if nums[mn] == nums[mx] { return moves }
            nums[mn] += 1
            moves += 1
        }
    }
}
*/

/*
Better Approach

class Solution {
    func minMoves(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        var moves = 0
        for x in sorted {
            moves += sorted[sorted.count - 1] - x
        }
        return moves
    }
}
*/

class Solution {
    func minMoves(_ nums: [Int]) -> Int {
        var mx = 0, sum = 0
        for x in nums {
            mx = max(mx, x)
            sum += x
        }
        return mx * nums.count - sum
    }
}