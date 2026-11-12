/*
Brute Force

class Solution {
    fun countNonDecreasingSubarrays(nums: IntArray, k: Int): Long {
        val n = nums.size
        var ans = 0L
        for (l in 0 until n) {
            var mx = 0
            var cost = 0L
            for (r in l until n) {
                mx = maxOf(mx, nums[r])
                cost += mx - nums[r]
                if (cost > k) break
                ans++
            }
        }
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    fun countNonDecreasingSubarrays(nums: IntArray, k: Int): Long {
        val n = nums.size
        var lg = 1
        while ((1 shl lg) <= n) lg++
        val pre = LongArray(n + 1)
        for (i in 0 until n) pre[i + 1] = pre[i] + nums[i]
        val up = Array(lg) { IntArray(n + 1) { n } }
        val sum = Array(lg) { LongArray(n + 1) }
        val st = IntArray(n)
        var top = 0
        for (i in n - 1 downTo 0) {
            while (top > 0 && nums[st[top - 1]] <= nums[i]) top--
            val nx = if (top > 0) st[top - 1] else n
            st[top++] = i
            up[0][i] = nx
            sum[0][i] = nums[i].toLong() * (nx - i) - (pre[nx] - pre[i])
        }
        for (j in 1 until lg) {
            for (i in 0..n) {
                up[j][i] = up[j - 1][up[j - 1][i]]
                sum[j][i] = sum[j - 1][i] + sum[j - 1][up[j - 1][i]]
            }
        }
        var ans = 0L
        for (l in 0 until n) {
            var cur = l
            var acc = 0L
            for (j in lg - 1 downTo 0) {
                if (cur < n && acc + sum[j][cur] <= k) {
                    acc += sum[j][cur]
                    cur = up[j][cur]
                }
            }
            if (cur == n) {
                ans += n - l
                continue
            }
            var lo = cur
            var hi = up[0][cur] - 1
            while (lo < hi) {
                val mid = (lo + hi + 1) / 2
                if (acc + nums[cur].toLong() * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) lo = mid else hi = mid - 1
            }
            ans += lo - l + 1
        }
        return ans
    }
}
*/

class Solution {
    fun countNonDecreasingSubarrays(nums: IntArray, k: Int): Long {
        val n = nums.size
        val dq = IntArray(n)
        var head = n
        var tail = n
        var r = n - 1
        var ans = 0L
        var cost = 0L
        for (l in n - 1 downTo 0) {
            while (head < tail && nums[dq[head]] <= nums[l]) {
                val i = dq[head++]
                val end = if (head < tail) dq[head] else r + 1
                cost += (nums[l] - nums[i]).toLong() * (end - i)
            }
            dq[--head] = l
            while (cost > k) {
                cost -= nums[dq[tail - 1]] - nums[r]
                if (dq[tail - 1] == r) tail--
                r--
            }
            ans += r - l + 1
        }
        return ans
    }
}