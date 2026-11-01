/*
Brute Force

impl Solution {
    pub fn sum_and_multiply(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        const MOD: i64 = 1_000_000_007;
        let b = s.as_bytes();
        queries
            .iter()
            .map(|q| {
                let (mut x, mut sum) = (0i64, 0i64);
                for i in q[0] as usize..=q[1] as usize {
                    let d = (b[i] - b'0') as i64;
                    if d != 0 {
                        x = (x * 10 + d) % MOD;
                        sum += d;
                    }
                }
                (x * sum % MOD) as i32
            })
            .collect()
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn sum_and_multiply(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        const MOD: i64 = 1_000_000_007;
        fn power(mut b: i64, mut e: usize) -> i64 {
            let mut r = 1;
            while e > 0 {
                if e & 1 == 1 {
                    r = r * b % MOD;
                }
                b = b * b % MOD;
                e >>= 1;
            }
            r
        }
        let b = s.as_bytes();
        let m = b.len();
        let mut pre = vec![0i64; m + 1];
        let mut cnt = vec![0usize; m + 1];
        let mut sum = vec![0i64; m + 1];
        for i in 0..m {
            let d = (b[i] - b'0') as i64;
            pre[i + 1] = if d != 0 { (pre[i] * 10 + d) % MOD } else { pre[i] };
            cnt[i + 1] = cnt[i] + (d != 0) as usize;
            sum[i + 1] = sum[i] + d;
        }
        queries
            .iter()
            .map(|q| {
                let (l, r) = (q[0] as usize, q[1] as usize + 1);
                let x = ((pre[r] - pre[l] * power(10, cnt[r] - cnt[l])) % MOD + MOD) % MOD;
                (x * (sum[r] - sum[l]) % MOD) as i32
            })
            .collect()
    }
}
*/

impl Solution {
    pub fn sum_and_multiply(s: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        const MOD: i64 = 1_000_000_007;
        let b = s.as_bytes();
        let m = b.len();
        let mut pre = vec![0i64; m + 1];
        let mut pw = vec![1i64; m + 1];
        let mut cnt = vec![0usize; m + 1];
        let mut sum = vec![0i64; m + 1];
        for i in 0..m {
            let d = (b[i] - b'0') as i64;
            pw[i + 1] = pw[i] * 10 % MOD;
            pre[i + 1] = if d != 0 { (pre[i] * 10 + d) % MOD } else { pre[i] };
            cnt[i + 1] = cnt[i] + (d != 0) as usize;
            sum[i + 1] = sum[i] + d;
        }
        queries
            .iter()
            .map(|q| {
                let (l, r) = (q[0] as usize, q[1] as usize + 1);
                let x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD + MOD) % MOD;
                (x * (sum[r] - sum[l]) % MOD) as i32
            })
            .collect()
    }
}