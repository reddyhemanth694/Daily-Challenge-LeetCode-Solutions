/*
Brute Force

impl Solution {
    pub fn min_moves(mut nums: Vec<i32>) -> i32 {
        let mut moves = 0;
        loop {
            let (mut mn, mut mx) = (0, 0);
            for i in 1..nums.len() {
                if nums[i] < nums[mn] {
                    mn = i;
                }
                if nums[i] > nums[mx] {
                    mx = i;
                }
            }
            if nums[mn] == nums[mx] {
                return moves;
            }
            nums[mn] += 1;
            moves += 1;
        }
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn min_moves(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let last = nums[nums.len() - 1];
        nums.iter().map(|&x| last - x).sum()
    }
}
*/

impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let (mut mx, mut sum) = (0, 0);
        for &x in &nums {
            mx = mx.max(x);
            sum += x;
        }
        mx * nums.len() as i32 - sum
    }
}