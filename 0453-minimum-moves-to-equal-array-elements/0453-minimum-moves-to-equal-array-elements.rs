/*
Brute Force

impl Solution {
    pub fn min_moves(mut nums: Vec<i32>) -> i32 {
        let mut moves = 0;
        loop {
            let mut mx = 0;
            let mut same = true;
            for i in 1..nums.len() {
                if nums[i] != nums[0] {
                    same = false;
                }
                if nums[i] > nums[mx] {
                    mx = i;
                }
            }
            if same {
                return moves;
            }
            for i in 0..nums.len() {
                if i != mx {
                    nums[i] += 1;
                }
            }
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
        let mut moves: i64 = 0;
        for &x in &nums {
            moves += x as i64 - nums[0] as i64;
        }
        moves as i32
    }
}
*/

impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let mn = *nums.iter().min().unwrap();
        let mut moves: i64 = 0;
        for &x in &nums {
            moves += x as i64 - mn as i64;
        }
        moves as i32
    }
}