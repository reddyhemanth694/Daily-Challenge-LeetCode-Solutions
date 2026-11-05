/*
Brute Force

class Solution {
    func findTheDistanceValue(_ arr1: [Int], _ arr2: [Int], _ d: Int) -> Int {
        var ans = 0
        for a in arr1 where arr2.allSatisfy({ abs(a - $0) > d }) {
            ans += 1
        }
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    func findTheDistanceValue(_ arr1: [Int], _ arr2: [Int], _ d: Int) -> Int {
        let b = arr2.sorted()
        var ans = 0
        for a in arr1 {
            var lo = 0, hi = b.count
            while lo < hi {
                let mid = (lo + hi) / 2
                if b[mid] < a - d { lo = mid + 1 } else { hi = mid }
            }
            if lo == b.count || b[lo] > a + d { ans += 1 }
        }
        return ans
    }
}
*/

class Solution {
    func findTheDistanceValue(_ arr1: [Int], _ arr2: [Int], _ d: Int) -> Int {
        var pre = [Int](repeating: 0, count: 2202)
        for v in arr2 { pre[v + 1101] += 1 }
        for i in 1..<2202 { pre[i] += pre[i - 1] }
        var ans = 0
        for a in arr1 where pre[a + d + 1101] == pre[a - d + 1100] {
            ans += 1
        }
        return ans
    }
}