/*
Brute Force

class Solution {
    func minMoves(nums: Array<Int64>): Int64 {
        var a = Array<Int64>(nums.size, {i => nums[i]})
        var moves = 0
        var done = false
        while (!done) {
            var mn = 0
            var mx = 0
            for (i in 1..a.size) {
                if (a[i] < a[mn]) {
                    mn = i
                }
                if (a[i] > a[mx]) {
                    mx = i
                }
            }
            if (a[mn] == a[mx]) {
                done = true
            } else {
                a[mn] += 1
                moves += 1
            }
        }
        moves
    }
}
*/

/*
Better Approach

import std.sort.*

class Solution {
    func minMoves(nums: Array<Int64>): Int64 {
        var a = Array<Int64>(nums.size, {i => nums[i]})
        sort(a)
        let last = a[a.size - 1]
        var moves = 0
        for (x in a) {
            moves += last - x
        }
        moves
    }
}
*/

class Solution {
    func minMoves(nums: Array<Int64>): Int64 {
        var mx = 0
        var sum = 0
        for (x in nums) {
            if (x > mx) {
                mx = x
            }
            sum += x
        }
        mx * nums.size - sum
    }
}