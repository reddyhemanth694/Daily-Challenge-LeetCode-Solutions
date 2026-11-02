/*
Brute Force

class Solution {
    func minMoves2(_ nums: [Int]) -> Int {
        var best = Int.max
        for x in nums {
            var cost = 0
            for a in nums {
                cost += abs(a - x)
            }
            best = min(best, cost)
        }
        return best
    }
}
*/

/*
Better Approach

class Solution {
    func minMoves2(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        let median = sorted[sorted.count / 2]
        var moves = 0
        for a in sorted {
            moves += abs(a - median)
        }
        return moves
    }
}
*/

class Solution {
    func minMoves2(_ nums: [Int]) -> Int {
        var a = nums
        let k = a.count / 2
        var lo = 0, hi = a.count - 1, median = 0
        while true {
            let pivot = a[Int.random(in: lo...hi)]
            var lt = lo, i = lo, gt = hi
            while i <= gt {
                if a[i] < pivot {
                    a.swapAt(lt, i)
                    lt += 1
                    i += 1
                } else if a[i] > pivot {
                    a.swapAt(i, gt)
                    gt -= 1
                } else {
                    i += 1
                }
            }
            if k < lt {
                hi = lt - 1
            } else if k > gt {
                lo = gt + 1
            } else {
                median = pivot
                break
            }
        }
        var moves = 0
        for x in nums {
            moves += abs(x - median)
        }
        return moves
    }
}