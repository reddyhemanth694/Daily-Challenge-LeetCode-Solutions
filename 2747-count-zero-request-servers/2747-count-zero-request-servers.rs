/*
Brute Force

impl Solution {
    pub fn count_servers(n: i32, logs: Vec<Vec<i32>>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        queries
            .iter()
            .map(|&q| {
                let mut seen = vec![false; n as usize + 1];
                let mut cnt = 0;
                for lg in &logs {
                    if lg[1] >= q - x && lg[1] <= q && !seen[lg[0] as usize] {
                        seen[lg[0] as usize] = true;
                        cnt += 1;
                    }
                }
                n - cnt
            })
            .collect()
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn count_servers(n: i32, mut logs: Vec<Vec<i32>>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        logs.sort_unstable_by_key(|lg| lg[1]);
        let m = logs.len();
        let mut stamp = vec![usize::MAX; n as usize + 1];
        let mut ans = vec![0; queries.len()];
        for (i, &q) in queries.iter().enumerate() {
            let mut j = logs.partition_point(|lg| lg[1] < q - x);
            let mut cnt = 0;
            while j < m && logs[j][1] <= q {
                let s = logs[j][0] as usize;
                if stamp[s] != i {
                    stamp[s] = i;
                    cnt += 1;
                }
                j += 1;
            }
            ans[i] = n - cnt;
        }
        ans
    }
}
*/

impl Solution {
    pub fn count_servers(n: i32, mut logs: Vec<Vec<i32>>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        logs.sort_unstable_by_key(|lg| lg[1]);
        let m = logs.len();
        let mut idx: Vec<usize> = (0..queries.len()).collect();
        idx.sort_unstable_by_key(|&i| queries[i]);
        let mut cnt = vec![0; n as usize + 1];
        let mut ans = vec![0; queries.len()];
        let (mut l, mut r, mut distinct) = (0, 0, 0);
        for i in idx {
            let q = queries[i];
            while r < m && logs[r][1] <= q {
                let s = logs[r][0] as usize;
                if cnt[s] == 0 {
                    distinct += 1;
                }
                cnt[s] += 1;
                r += 1;
            }
            while l < r && logs[l][1] < q - x {
                let s = logs[l][0] as usize;
                cnt[s] -= 1;
                if cnt[s] == 0 {
                    distinct -= 1;
                }
                l += 1;
            }
            ans[i] = n - distinct;
        }
        ans
    }
}