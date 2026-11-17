/*
Brute Force

class Solution {
    func minChanges(_ s: String) -> Int {
        let a = Array(s)
        let n = a.count
        func solve(_ i: Int) -> Int {
            if i == n { return 0 }
            var best = n, ones = 0
            for j in i..<n {
                if a[j] == "1" { ones += 1 }
                let len = j - i + 1
                if len % 2 == 0 { best = min(best, min(ones, len - ones) + solve(j + 1)) }
            }
            return best
        }
        return solve(0)
    }
}
*/

/*
Better Approach

class Solution {
    func minChanges(_ s: String) -> Int {
        let a = Array(s)
        let n = a.count
        var dp = [Int](repeating: n, count: n + 1)
        dp[0] = 0
        for i in stride(from: 0, to: n, by: 2) {
            var ones = 0
            for j in i..<n {
                if a[j] == "1" { ones += 1 }
                let len = j - i + 1
                if len % 2 == 0 { dp[j + 1] = min(dp[j + 1], dp[i] + min(ones, len - ones)) }
            }
        }
        return dp[n]
    }
}
*/

class Solution {
    func minChanges(_ s: String) -> Int {
        let a = Array(s.utf8)
        var ans = 0
        for i in stride(from: 0, to: a.count, by: 2) where a[i] != a[i + 1] {
            ans += 1
        }
        return ans
    }
}