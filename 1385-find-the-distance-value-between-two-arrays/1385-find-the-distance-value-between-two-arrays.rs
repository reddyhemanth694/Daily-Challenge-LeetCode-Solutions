/*
Brute Force

impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, arr2: Vec<i32>, d: i32) -> i32 {
        arr1.iter().filter(|&&a| arr2.iter().all(|&b| (a - b).abs() > d)).count() as i32
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, mut arr2: Vec<i32>, d: i32) -> i32 {
        arr2.sort();
        let mut ans = 0;
        for &a in &arr1 {
            let i = arr2.partition_point(|&b| b < a - d);
            if i == arr2.len() || arr2[i] > a + d {
                ans += 1;
            }
        }
        ans
    }
}
*/

impl Solution {
    pub fn find_the_distance_value(arr1: Vec<i32>, arr2: Vec<i32>, d: i32) -> i32 {
        let mut pre = vec![0; 2202];
        for &v in &arr2 {
            pre[(v + 1101) as usize] += 1;
        }
        for i in 1..2202 {
            pre[i] += pre[i - 1];
        }
        arr1.iter().filter(|&&a| pre[(a + d + 1101) as usize] == pre[(a - d + 1100) as usize]).count() as i32
    }
}