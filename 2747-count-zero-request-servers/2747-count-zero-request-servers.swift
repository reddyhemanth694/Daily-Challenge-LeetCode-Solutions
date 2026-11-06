/*
Brute Force

class Solution {
    func countServers(_ n: Int, _ logs: [[Int]], _ x: Int, _ queries: [Int]) -> [Int] {
        return queries.map { q -> Int in
            var seen = [Bool](repeating: false, count: n + 1)
            var cnt = 0
            for lg in logs where lg[1] >= q - x && lg[1] <= q && !seen[lg[0]] {
                seen[lg[0]] = true
                cnt += 1
            }
            return n - cnt
        }
    }
}
*/

/*
Better Approach

class Solution {
    func countServers(_ n: Int, _ logs: [[Int]], _ x: Int, _ queries: [Int]) -> [Int] {
        let lg = logs.sorted { $0[1] < $1[1] }
        let m = lg.count
        var stamp = [Int](repeating: -1, count: n + 1)
        var ans = [Int](repeating: 0, count: queries.count)
        for (i, q) in queries.enumerated() {
            var lo = 0, hi = m
            while lo < hi {
                let mid = (lo + hi) / 2
                if lg[mid][1] < q - x { lo = mid + 1 } else { hi = mid }
            }
            var cnt = 0
            var j = lo
            while j < m && lg[j][1] <= q {
                if stamp[lg[j][0]] != i {
                    stamp[lg[j][0]] = i
                    cnt += 1
                }
                j += 1
            }
            ans[i] = n - cnt
        }
        return ans
    }
}
*/

class Solution {
    func countServers(_ n: Int, _ logs: [[Int]], _ x: Int, _ queries: [Int]) -> [Int] {
        let lg = logs.sorted { $0[1] < $1[1] }
        let m = lg.count
        let idx = queries.indices.sorted { queries[$0] < queries[$1] }
        var cnt = [Int](repeating: 0, count: n + 1)
        var ans = [Int](repeating: 0, count: queries.count)
        var l = 0, r = 0, distinct = 0
        for i in idx {
            let q = queries[i]
            while r < m && lg[r][1] <= q {
                if cnt[lg[r][0]] == 0 { distinct += 1 }
                cnt[lg[r][0]] += 1
                r += 1
            }
            while l < r && lg[l][1] < q - x {
                cnt[lg[l][0]] -= 1
                if cnt[lg[l][0]] == 0 { distinct -= 1 }
                l += 1
            }
            ans[i] = n - distinct
        }
        return ans
    }
}