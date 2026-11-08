/*
Brute Force
class Solution {
    func countServers(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid[0].count
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    var found = false
                    for k in 0..<n where k != j && grid[i][k] == 1 { found = true }
                    for k in 0..<m where k != i && grid[k][j] == 1 { found = true }
                    if found { ans += 1 }
                }
            }
        }
        return ans
    }
}
*/

/*
Better Approach
class Solution {
    func countServers(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid[0].count
        var row = [Int](repeating: 0, count: m)
        var col = [Int](repeating: 0, count: n)
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 { row[i] += 1; col[j] += 1 }
            }
        }
        var ans = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 && (row[i] > 1 || col[j] > 1) { ans += 1 }
            }
        }
        return ans
    }
}
*/

// Optimized Approach: one pass, answer = total - isolated
class Solution {
    func countServers(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid[0].count
        var rowCnt = [Int](repeating: 0, count: m)
        var rowCol = [Int](repeating: 0, count: m)
        var colCnt = [Int](repeating: 0, count: n)
        var total = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    rowCnt[i] += 1
                    rowCol[i] += j
                    colCnt[j] += 1
                    total += 1
                }
            }
        }
        var isolated = 0
        for i in 0..<m {
            if rowCnt[i] == 1 && colCnt[rowCol[i]] == 1 { isolated += 1 }
        }
        return total - isolated
    }
}