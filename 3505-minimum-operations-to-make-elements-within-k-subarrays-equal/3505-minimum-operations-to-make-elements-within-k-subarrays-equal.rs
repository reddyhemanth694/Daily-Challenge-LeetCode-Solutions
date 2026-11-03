/*
Brute Force

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32, k: i32) -> i64 {
        fn window_cost(nums: &[i32], i: usize, x: usize) -> i64 {
            let mut w = nums[i..i + x].to_vec();
            w.sort();
            let med = w[x / 2] as i64;
            w.iter().map(|&v| (v as i64 - med).abs()).sum()
        }
        fn dfs(nums: &[i32], x: usize, i: usize, j: usize) -> i64 {
            if j == 0 {
                return 0;
            }
            if nums.len() - i < j * x {
                return i64::MAX;
            }
            let skip = dfs(nums, x, i + 1, j);
            let take = window_cost(nums, i, x) + dfs(nums, x, i + x, j - 1);
            skip.min(take)
        }
        dfs(&nums, x as usize, 0, k as usize)
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32, k: i32) -> i64 {
        let (n, x, k) = (nums.len(), x as usize, k as usize);
        let mut cost = vec![0i64; n - x + 1];
        for i in 0..=n - x {
            let mut w = nums[i..i + x].to_vec();
            w.sort();
            let med = w[x / 2] as i64;
            cost[i] = w.iter().map(|&v| (v as i64 - med).abs()).sum();
        }
        let inf = i64::MAX / 4;
        let mut prev = vec![0i64; n + 1];
        let mut cur = vec![0i64; n + 1];
        for _ in 0..k {
            cur.iter_mut().for_each(|c| *c = inf);
            for i in x..=n {
                cur[i] = cur[i - 1].min(prev[i - x] + cost[i - x]);
            }
            std::mem::swap(&mut prev, &mut cur);
        }
        prev[n]
    }
}
*/

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32, k: i32) -> i64 {
        let (n, x, k) = (nums.len(), x as usize, k as usize);
        let mut vals = nums.clone();
        vals.sort();
        vals.dedup();
        let m = vals.len();
        let mut top = 1;
        while top * 2 <= m {
            top *= 2;
        }
        let idx: Vec<usize> = nums.iter().map(|v| vals.binary_search(v).unwrap() + 1).collect();
        let mut cnt = vec![0i64; m + 1];
        let mut sum = vec![0i64; m + 1];
        let mut cost = vec![0i64; n - x + 1];
        let mut total = 0i64;
        let half = ((x + 1) / 2) as i64;
        for i in 0..n {
            let mut p = idx[i];
            while p <= m {
                cnt[p] += 1;
                sum[p] += nums[i] as i64;
                p += p & p.wrapping_neg();
            }
            total += nums[i] as i64;
            if i >= x {
                let mut p = idx[i - x];
                while p <= m {
                    cnt[p] -= 1;
                    sum[p] -= nums[i - x] as i64;
                    p += p & p.wrapping_neg();
                }
                total -= nums[i - x] as i64;
            }
            if i + 1 >= x {
                let (mut pos, mut need, mut low_cnt, mut low_sum, mut step) = (0usize, half, 0i64, 0i64, top);
                while step > 0 {
                    if pos + step <= m && cnt[pos + step] < need {
                        pos += step;
                        need -= cnt[pos];
                        low_cnt += cnt[pos];
                        low_sum += sum[pos];
                    }
                    step >>= 1;
                }
                let med = vals[pos] as i64;
                cost[i + 1 - x] = med * low_cnt - low_sum + (total - low_sum) - med * (x as i64 - low_cnt);
            }
        }
        let inf = i64::MAX / 4;
        let mut prev = vec![0i64; n + 1];
        let mut cur = vec![0i64; n + 1];
        for _ in 0..k {
            cur.iter_mut().for_each(|c| *c = inf);
            for i in x..=n {
                cur[i] = cur[i - 1].min(prev[i - x] + cost[i - x]);
            }
            std::mem::swap(&mut prev, &mut cur);
        }
        prev[n]
    }
}