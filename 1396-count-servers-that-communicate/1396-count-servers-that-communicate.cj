/*
Brute Force
Time: O(m * n * (m + n))   Space: O(1)
For every server, scan its whole row and whole column for another server.

class Solution {
    func countServers(grid: Array<Array<Int64>>): Int64 {
        let m = grid.size
        let n = grid[0].size
        var ans: Int64 = 0
        for (i in 0..m) {
            for (j in 0..n) {
                if (grid[i][j] == 1) {
                    var found = false
                    for (k in 0..n) {
                        if (k != j && grid[i][k] == 1) {
                            found = true
                        }
                    }
                    for (k in 0..m) {
                        if (k != i && grid[k][j] == 1) {
                            found = true
                        }
                    }
                    if (found) {
                        ans += 1
                    }
                }
            }
        }
        return ans
    }
}
*/

/*
Better Approach
Time: O(m * n)   Space: O(m + n)
Count servers per row and per column, then make a second full pass:
a server communicates if its row count > 1 or its column count > 1.

class Solution {
    func countServers(grid: Array<Array<Int64>>): Int64 {
        let m = grid.size
        let n = grid[0].size
        var row = Array<Int64>(m, {i => 0})
        var col = Array<Int64>(n, {i => 0})
        for (i in 0..m) {
            for (j in 0..n) {
                if (grid[i][j] == 1) {
                    row[i] += 1
                    col[j] += 1
                }
            }
        }
        var ans: Int64 = 0
        for (i in 0..m) {
            for (j in 0..n) {
                if (grid[i][j] == 1 && (row[i] > 1 || col[j] > 1)) {
                    ans += 1
                }
            }
        }
        return ans
    }
}
*/

// Optimized Approach
// Time: O(m * n) with a single pass over the grid, plus O(m) cleanup   Space: O(m + n)
// Count the total servers and remember, for each row, the sum of the column
// indices of its servers. If a row has exactly one server, that sum is
// the server's column. Only such lone-in-row servers can be isolated, and they are
// isolated exactly when their column also holds one server. So:
// answer = total - (number of isolated servers). No second full scan is needed.
class Solution {
    func countServers(grid: Array<Array<Int64>>): Int64 {
        let m = grid.size
        let n = grid[0].size
        var rowCnt = Array<Int64>(m, {i => 0})
        var rowColSum = Array<Int64>(m, {i => 0})
        var colCnt = Array<Int64>(n, {i => 0})
        var total: Int64 = 0
        for (i in 0..m) {
            for (j in 0..n) {
                if (grid[i][j] == 1) {
                    rowCnt[i] += 1
                    rowColSum[i] += Int64(j)
                    colCnt[j] += 1
                    total += 1
                }
            }
        }
        var isolated: Int64 = 0
        for (i in 0..m) {
            if (rowCnt[i] == 1 && colCnt[rowColSum[i]] == 1) {
                isolated += 1
            }
        }
        return total - isolated
    }
}