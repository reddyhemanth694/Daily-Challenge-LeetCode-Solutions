/*
Brute Force
impl Solution {
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut ans = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    let mut found = false;
                    for k in 0..n {
                        if k != j && grid[i][k] == 1 { found = true; }
                    }
                    for k in 0..m {
                        if k != i && grid[k][j] == 1 { found = true; }
                    }
                    if found { ans += 1; }
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
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut row = vec![0; m];
        let mut col = vec![0; n];
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    row[i] += 1;
                    col[j] += 1;
                }
            }
        }
        let mut ans = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 && (row[i] > 1 || col[j] > 1) {
                    ans += 1;
                }
            }
        }
        ans
    }
}
*/

// Optimized Approach: one pass, answer = total - isolated
impl Solution {
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut row_cnt = vec![0i32; m];
        let mut row_col = vec![0usize; m];
        let mut col_cnt = vec![0i32; n];
        let mut total = 0i32;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    row_cnt[i] += 1;
                    row_col[i] += j;
                    col_cnt[j] += 1;
                    total += 1;
                }
            }
        }
        let mut isolated = 0i32;
        for i in 0..m {
            if row_cnt[i] == 1 && col_cnt[row_col[i]] == 1 {
                isolated += 1;
            }
        }
        total - isolated
    }
}