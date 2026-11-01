/*
Brute Force

impl Solution {
    pub fn sum_and_multiply(n: i32) -> i64 {
        let t: String = n.to_string().chars().filter(|&c| c != '0').collect();
        if t.is_empty() {
            return 0;
        }
        let x: i64 = t.parse().unwrap();
        let sum: i64 = t.bytes().map(|b| (b - b'0') as i64).sum();
        x * sum
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn sum_and_multiply(mut n: i32) -> i64 {
        let mut digits = vec![];
        while n > 0 {
            digits.push((n % 10) as i64);
            n /= 10;
        }
        let (mut x, mut sum) = (0i64, 0i64);
        for &d in digits.iter().rev() {
            if d != 0 {
                x = x * 10 + d;
                sum += d;
            }
        }
        x * sum
    }
}
*/

impl Solution {
    pub fn sum_and_multiply(mut n: i32) -> i64 {
        let (mut x, mut sum, mut p) = (0i64, 0i64, 1i64);
        while n > 0 {
            let d = (n % 10) as i64;
            if d != 0 {
                x += d * p;
                sum += d;
                p *= 10;
            }
            n /= 10;
        }
        x * sum
    }
}