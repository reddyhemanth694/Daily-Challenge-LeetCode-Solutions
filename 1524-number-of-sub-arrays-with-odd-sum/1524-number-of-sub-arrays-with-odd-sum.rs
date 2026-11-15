/*
Brute Force

impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = arr.len();
        let mut ans = 0;
        for i in 0..n {
            for j in i..n {
                let sum: i32 = arr[i..=j].iter().sum();
                if sum % 2 == 1 {
                    ans = (ans + 1) % MOD;
                }
            }
        }
        ans
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = arr.len();
        let mut ans = 0;
        for i in 0..n {
            let mut sum = 0;
            for j in i..n {
                sum += arr[j];
                if sum % 2 == 1 {
                    ans = (ans + 1) % MOD;
                }
            }
        }
        ans
    }
}
*/

impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let (mut odd, mut even, mut sum, mut ans) = (0, 1, 0, 0);
        for x in arr {
            sum += x;
            if sum % 2 == 1 {
                ans = (ans + even) % MOD;
                odd += 1;
            } else {
                ans = (ans + odd) % MOD;
                even += 1;
            }
        }
        ans
    }
}