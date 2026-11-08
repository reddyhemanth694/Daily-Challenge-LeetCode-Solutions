/*
Brute Force
func countServers(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    ans := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                found := false
                for k := 0; k < n; k++ {
                    if k != j && grid[i][k] == 1 {
                        found = true
                    }
                }
                for k := 0; k < m; k++ {
                    if k != i && grid[k][j] == 1 {
                        found = true
                    }
                }
                if found {
                    ans++
                }
            }
        }
    }
    return ans
}
*/

/*
Better Approach
func countServers(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    row := make([]int, m)
    col := make([]int, n)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                row[i]++
                col[j]++
            }
        }
    }
    ans := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 && (row[i] > 1 || col[j] > 1) {
                ans++
            }
        }
    }
    return ans
}
*/

// Optimized Approach: one pass, answer = total - isolated
func countServers(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    rowCnt := make([]int, m)
    rowCol := make([]int, m)
    colCnt := make([]int, n)
    total := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                rowCnt[i]++
                rowCol[i] += j
                colCnt[j]++
                total++
            }
        }
    }
    isolated := 0
    for i := 0; i < m; i++ {
        if rowCnt[i] == 1 && colCnt[rowCol[i]] == 1 {
            isolated++
        }
    }
    return total - isolated
}