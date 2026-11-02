/*
Brute Force

impl Solution {
    pub fn min_moves2(nums: Vec<i32>) -> i32 {
        let mut best = i64::MAX;
        for &x in &nums {
            let cost: i64 = nums.iter().map(|&a| (a as i64 - x as i64).abs()).sum();
            best = best.min(cost);
        }
        best as i32
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn min_moves2(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let median = nums[nums.len() / 2] as i64;
        nums.iter().map(|&a| (a as i64 - median).abs()).sum::<i64>() as i32
    }
}
*/

impl Solution {
    pub fn min_moves2(mut nums: Vec<i32>) -> i32 {
        let k = nums.len() / 2;
        let median = *nums.select_nth_unstable(k).1 as i64;
        nums.iter().map(|&a| (a as i64 - median).abs()).sum::<i64>() as i32
    }
}