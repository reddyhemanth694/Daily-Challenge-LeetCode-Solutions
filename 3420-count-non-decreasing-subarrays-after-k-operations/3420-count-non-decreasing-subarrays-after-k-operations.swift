/*
Brute Force

class Solution {
    func countNonDecreasingSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var ans = 0
        for l in 0..<n {
            var mx = 0, cost = 0
            for r in l..<n {
                mx = max(mx, nums[r])
                cost += mx - nums[r]
                if cost > k { break }
                ans += 1
            }
        }
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    func countNonDecreasingSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var lg = 1
        while (1 << lg) <= n { lg += 1 }
        var pre = [Int](repeating: 0, count: n + 1)
        for i in 0..<n { pre[i + 1] = pre[i] + nums[i] }
        var up = [[Int]](repeating: [Int](repeating: n, count: n + 1), count: lg)
        var sum = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: lg)
        var st = [Int]()
        for i in stride(from: n - 1, through: 0, by: -1) {
            while let t = st.last, nums[t] <= nums[i] { st.removeLast() }
            let nx = st.last ?? n
            st.append(i)
            up[0][i] = nx
            sum[0][i] = nums[i] * (nx - i) - (pre[nx] - pre[i])
        }
        for j in 1..<max(lg, 1) where j < lg {
            for i in 0...n {
                up[j][i] = up[j - 1][up[j - 1][i]]
                sum[j][i] = sum[j - 1][i] + sum[j - 1][up[j - 1][i]]
            }
        }
        var ans = 0
        for l in 0..<n {
            var cur = l, acc = 0
            for j in stride(from: lg - 1, through: 0, by: -1) {
                if cur < n && acc + sum[j][cur] <= k {
                    acc += sum[j][cur]
                    cur = up[j][cur]
                }
            }
            if cur == n {
                ans += n - l
                continue
            }
            var lo = cur, hi = up[0][cur] - 1
            while lo < hi {
                let mid = (lo + hi + 1) / 2
                if acc + nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k { lo = mid } else { hi = mid - 1 }
            }
            ans += lo - l + 1
        }
        return ans
    }
}
*/

class Solution {
    func countNonDecreasingSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var dq = [Int](repeating: 0, count: n)
        var head = n, tail = n, r = n - 1, ans = 0, cost = 0
        for l in stride(from: n - 1, through: 0, by: -1) {
            while head < tail && nums[dq[head]] <= nums[l] {
                let i = dq[head]
                head += 1
                let end = head < tail ? dq[head] : r + 1
                cost += (nums[l] - nums[i]) * (end - i)
            }
            head -= 1
            dq[head] = l
            while cost > k {
                cost -= nums[dq[tail - 1]] - nums[r]
                if dq[tail - 1] == r { tail -= 1 }
                r -= 1
            }
            ans += r - l + 1
        }
        return ans
    }
}