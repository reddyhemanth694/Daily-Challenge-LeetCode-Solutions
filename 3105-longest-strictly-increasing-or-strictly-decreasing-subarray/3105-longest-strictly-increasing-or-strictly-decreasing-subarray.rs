/*
Brute Force

impl Solution {
    pub fn longest_monotonic_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut res = 1;
        for i in 0..n {
            let (mut inc, mut dec) = (1, 1);
            while i + inc < n && nums[i + inc] > nums[i + inc - 1] {
                inc += 1;
            }
            while i + dec < n && nums[i + dec] < nums[i + dec - 1] {
                dec += 1;
            }
            res = res.max(inc).max(dec);
        }
        res as i32
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn longest_monotonic_subarray(nums: Vec<i32>) -> i32 {
        let (mut res, mut len) = (1, 1);
        for i in 1..nums.len() {
            len = if nums[i] > nums[i - 1] { len + 1 } else { 1 };
            res = res.max(len);
        }
        len = 1;
        for i in 1..nums.len() {
            len = if nums[i] < nums[i - 1] { len + 1 } else { 1 };
            res = res.max(len);
        }
        res
    }
}
*/

impl Solution {
    pub fn longest_monotonic_subarray(nums: Vec<i32>) -> i32 {
        let (mut res, mut inc, mut dec) = (1, 1, 1);
        for i in 1..nums.len() {
            inc = if nums[i] > nums[i - 1] { inc + 1 } else { 1 };
            dec = if nums[i] < nums[i - 1] { dec + 1 } else { 1 };
            res = res.max(inc).max(dec);
        }
        res
    }
}