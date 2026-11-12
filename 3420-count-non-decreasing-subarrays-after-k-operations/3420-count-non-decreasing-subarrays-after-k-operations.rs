/*
Brute Force

impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let (n, k) = (nums.len(), k as i64);
        let mut ans = 0i64;
        for l in 0..n {
            let (mut mx, mut cost) = (0i64, 0i64);
            for r in l..n {
                mx = mx.max(nums[r] as i64);
                cost += mx - nums[r] as i64;
                if cost > k {
                    break;
                }
                ans += 1;
            }
        }
        ans
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let (n, k) = (nums.len(), k as i64);
        let mut lg = 1;
        while (1usize << lg) <= n {
            lg += 1;
        }
        let mut pre = vec![0i64; n + 1];
        for i in 0..n {
            pre[i + 1] = pre[i] + nums[i] as i64;
        }
        let mut up = vec![vec![n; n + 1]; lg];
        let mut sum = vec![vec![0i64; n + 1]; lg];
        let mut st: Vec<usize> = Vec::new();
        for i in (0..n).rev() {
            while let Some(&t) = st.last() {
                if nums[t] > nums[i] {
                    break;
                }
                st.pop();
            }
            let nx = *st.last().unwrap_or(&n);
            st.push(i);
            up[0][i] = nx;
            sum[0][i] = nums[i] as i64 * (nx - i) as i64 - (pre[nx] - pre[i]);
        }
        for j in 1..lg {
            for i in 0..=n {
                let mid = up[j - 1][i];
                up[j][i] = up[j - 1][mid];
                sum[j][i] = sum[j - 1][i] + sum[j - 1][mid];
            }
        }
        let mut ans = 0i64;
        for l in 0..n {
            let (mut cur, mut acc) = (l, 0i64);
            for j in (0..lg).rev() {
                if cur < n && acc + sum[j][cur] <= k {
                    acc += sum[j][cur];
                    cur = up[j][cur];
                }
            }
            if cur == n {
                ans += (n - l) as i64;
                continue;
            }
            let (mut lo, mut hi) = (cur, up[0][cur] - 1);
            while lo < hi {
                let mid = (lo + hi + 1) / 2;
                if acc + nums[cur] as i64 * (mid - cur + 1) as i64 - (pre[mid + 1] - pre[cur]) <= k {
                    lo = mid;
                } else {
                    hi = mid - 1;
                }
            }
            ans += (lo - l + 1) as i64;
        }
        ans
    }
}
*/

impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let (n, k) = (nums.len(), k as i64);
        let mut dq = vec![0usize; n];
        let (mut head, mut tail, mut r) = (n, n, n - 1);
        let (mut ans, mut cost) = (0i64, 0i64);
        for l in (0..n).rev() {
            while head < tail && nums[dq[head]] <= nums[l] {
                let i = dq[head];
                head += 1;
                let end = if head < tail { dq[head] } else { r + 1 };
                cost += (nums[l] - nums[i]) as i64 * (end - i) as i64;
            }
            head -= 1;
            dq[head] = l;
            while cost > k {
                cost -= (nums[dq[tail - 1]] - nums[r]) as i64;
                if dq[tail - 1] == r {
                    tail -= 1;
                }
                r -= 1;
            }
            ans += (r - l + 1) as i64;
        }
        ans
    }
}