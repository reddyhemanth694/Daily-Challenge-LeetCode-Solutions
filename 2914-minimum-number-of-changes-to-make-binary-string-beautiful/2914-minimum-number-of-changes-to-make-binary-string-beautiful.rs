/*
Brute Force

impl Solution {
    pub fn min_changes(s: String) -> i32 {
        fn solve(b: &[u8], i: usize) -> i32 {
            let n = b.len();
            if i == n {
                return 0;
            }
            let mut best = n as i32;
            let mut ones: i32 = 0;
            for j in i..n {
                if b[j] == b'1' {
                    ones += 1;
                }
                let len = (j - i + 1) as i32;
                if len % 2 == 0 {
                    best = best.min(ones.min(len - ones) + solve(b, j + 1));
                }
            }
            best
        }
        solve(s.as_bytes(), 0)
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn min_changes(s: String) -> i32 {
        let b = s.as_bytes();
        let n = b.len();
        let mut dp = vec![n as i32; n + 1];
        dp[0] = 0;
        for i in (0..n).step_by(2) {
            let mut ones: i32 = 0;
            for j in i..n {
                if b[j] == b'1' {
                    ones += 1;
                }
                let len = (j - i + 1) as i32;
                if len % 2 == 0 {
                    dp[j + 1] = dp[j + 1].min(dp[i] + ones.min(len - ones));
                }
            }
        }
        dp[n]
    }
}
*/

impl Solution {
    pub fn min_changes(s: String) -> i32 {
        s.as_bytes().chunks(2).filter(|p| p[0] != p[1]).count() as i32
    }
}