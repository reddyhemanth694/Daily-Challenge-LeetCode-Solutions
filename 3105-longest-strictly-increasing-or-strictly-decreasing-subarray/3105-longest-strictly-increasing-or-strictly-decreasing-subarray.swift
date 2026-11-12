/*
Brute Force

class Solution {
    func longestMonotonicSubarray(_ nums: [Int]) -> Int {
        let n = nums.count
        var res = 1
        for i in 0..<n {
            var inc = 1, dec = 1
            while i + inc < n && nums[i + inc] > nums[i + inc - 1] { inc += 1 }
            while i + dec < n && nums[i + dec] < nums[i + dec - 1] { dec += 1 }
            res = max(res, inc, dec)
        }
        return res
    }
}
*/

/*
Better Approach

class Solution {
    func longestMonotonicSubarray(_ nums: [Int]) -> Int {
        var res = 1, len = 1
        for i in 1..<nums.count {
            len = nums[i] > nums[i - 1] ? len + 1 : 1
            res = max(res, len)
        }
        len = 1
        for i in 1..<nums.count {
            len = nums[i] < nums[i - 1] ? len + 1 : 1
            res = max(res, len)
        }
        return res
    }
}
*/

class Solution {
    func longestMonotonicSubarray(_ nums: [Int]) -> Int {
        var res = 1, inc = 1, dec = 1
        for i in 1..<nums.count {
            inc = nums[i] > nums[i - 1] ? inc + 1 : 1
            dec = nums[i] < nums[i - 1] ? dec + 1 : 1
            res = max(res, inc, dec)
        }
        return res
    }
}