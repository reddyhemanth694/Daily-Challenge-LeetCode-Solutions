/*
Brute Force

class Solution {
    func sumAndMultiply(_ s: String, _ queries: [[Int]]) -> [Int] {
        let mod = 1_000_000_007
        let digits = s.utf8.map { Int($0) - 48 }
        return queries.map { q -> Int in
            var x = 0, sum = 0
            for i in q[0]...q[1] where digits[i] != 0 {
                x = (x * 10 + digits[i]) % mod
                sum += digits[i]
            }
            return x * sum % mod
        }
    }
}
*/

/*
Better Approach

class Solution {
    func sumAndMultiply(_ s: String, _ queries: [[Int]]) -> [Int] {
        let mod = 1_000_000_007
        func power(_ base: Int, _ exp: Int) -> Int {
            var b = base, e = exp, r = 1
            while e > 0 {
                if e & 1 == 1 { r = r * b % mod }
                b = b * b % mod
                e >>= 1
            }
            return r
        }
        let digits = s.utf8.map { Int($0) - 48 }
        let m = digits.count
        var pre = [Int](repeating: 0, count: m + 1)
        var cnt = [Int](repeating: 0, count: m + 1)
        var sum = [Int](repeating: 0, count: m + 1)
        for i in 0..<m {
            let d = digits[i]
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % mod : pre[i]
            cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0)
            sum[i + 1] = sum[i] + d
        }
        return queries.map { q -> Int in
            let l = q[0], r = q[1] + 1
            let x = ((pre[r] - pre[l] * power(10, cnt[r] - cnt[l])) % mod + mod) % mod
            return x * (sum[r] - sum[l]) % mod
        }
    }
}
*/

class Solution {
    func sumAndMultiply(_ s: String, _ queries: [[Int]]) -> [Int] {
        let mod = 1_000_000_007
        let digits = s.utf8.map { Int($0) - 48 }
        let m = digits.count
        var pre = [Int](repeating: 0, count: m + 1)
        var pw = [Int](repeating: 1, count: m + 1)
        var cnt = [Int](repeating: 0, count: m + 1)
        var sum = [Int](repeating: 0, count: m + 1)
        for i in 0..<m {
            let d = digits[i]
            pw[i + 1] = pw[i] * 10 % mod
            pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % mod : pre[i]
            cnt[i + 1] = cnt[i] + (d != 0 ? 1 : 0)
            sum[i + 1] = sum[i] + d
        }
        return queries.map { q -> Int in
            let l = q[0], r = q[1] + 1
            let x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % mod + mod) % mod
            return x * (sum[r] - sum[l]) % mod
        }
    }
}