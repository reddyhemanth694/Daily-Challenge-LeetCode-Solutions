/*
Brute Force

class Solution {
    func minOperations(_ nums: [Int], _ x: Int, _ k: Int) -> Int {
        let n = nums.count
        func windowCost(_ i: Int) -> Int {
            let w = nums[i..<(i + x)].sorted()
            let med = w[x / 2]
            var cost = 0
            for v in w { cost += abs(v - med) }
            return cost
        }
        func dfs(_ i: Int, _ j: Int) -> Int {
            if j == 0 { return 0 }
            if n - i < j * x { return Int.max }
            let skip = dfs(i + 1, j)
            let take = windowCost(i) + dfs(i + x, j - 1)
            return min(skip, take)
        }
        return dfs(0, k)
    }
}
*/

/*
Better Approach

class Solution {
    func minOperations(_ nums: [Int], _ x: Int, _ k: Int) -> Int {
        let n = nums.count
        var cost = [Int](repeating: 0, count: n - x + 1)
        for i in 0...(n - x) {
            let w = nums[i..<(i + x)].sorted()
            let med = w[x / 2]
            for v in w { cost[i] += abs(v - med) }
        }
        let inf = Int.max / 4
        var prev = [Int](repeating: 0, count: n + 1)
        var cur = [Int](repeating: 0, count: n + 1)
        for _ in 0..<k {
            for i in 0...n { cur[i] = inf }
            for i in stride(from: x, through: n, by: 1) {
                cur[i] = min(cur[i - 1], prev[i - x] + cost[i - x])
            }
            swap(&prev, &cur)
        }
        return prev[n]
    }
}
*/

class Solution {
    func minOperations(_ nums: [Int], _ x: Int, _ k: Int) -> Int {
        let n = nums.count
        let vals = Array(Set(nums)).sorted()
        let m = vals.count
        var pos = [Int: Int]()
        for (i, v) in vals.enumerated() { pos[v] = i + 1 }
        let idx = nums.map { pos[$0]! }
        var top = 1
        while top * 2 <= m { top *= 2 }
        var cnt = [Int](repeating: 0, count: m + 1)
        var sum = [Int](repeating: 0, count: m + 1)
        var cost = [Int](repeating: 0, count: n - x + 1)
        func update(_ i: Int, _ d: Int) {
            var p = idx[i]
            while p <= m {
                cnt[p] += d
                sum[p] += d * nums[i]
                p += p & -p
            }
        }
        var total = 0
        let half = (x + 1) / 2
        for i in 0..<n {
            update(i, 1)
            total += nums[i]
            if i >= x {
                update(i - x, -1)
                total -= nums[i - x]
            }
            if i >= x - 1 {
                var p = 0, need = half, lowCnt = 0, lowSum = 0, step = top
                while step > 0 {
                    if p + step <= m && cnt[p + step] < need {
                        p += step
                        need -= cnt[p]
                        lowCnt += cnt[p]
                        lowSum += sum[p]
                    }
                    step >>= 1
                }
                let med = vals[p]
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt)
            }
        }
        let inf = Int.max / 4
        var prev = [Int](repeating: 0, count: n + 1)
        var cur = [Int](repeating: 0, count: n + 1)
        for _ in 0..<k {
            for i in 0...n { cur[i] = inf }
            for i in stride(from: x, through: n, by: 1) {
                cur[i] = min(cur[i - 1], prev[i - x] + cost[i - x])
            }
            swap(&prev, &cur)
        }
        return prev[n]
    }
}