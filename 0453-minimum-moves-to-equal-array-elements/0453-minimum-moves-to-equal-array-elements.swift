/*
Brute Force

class Solution {
    func minMoves(_ nums: [Int]) -> Int {
        var nums = nums
        var moves = 0
        while true {
            var mx = 0
            var same = true
            for i in 1..<nums.count {
                if nums[i] != nums[0] { same = false }
                if nums[i] > nums[mx] { mx = i }
            }
            if same { return moves }
            for i in 0..<nums.count where i != mx {
                nums[i] += 1
            }
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
            moves += x - sorted[0]
        }
        return moves
    }
}
*/

class Solution {
    func minMoves(_ nums: [Int]) -> Int {
        let mn = nums.min()!
        var moves = 0
        for x in nums {
            moves += x - mn
        }
        return moves
    }
}