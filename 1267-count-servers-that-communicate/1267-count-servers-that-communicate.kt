/*
Brute Force
class Solution {
    fun countServers(grid: Array<IntArray>): Int {
        val m = grid.size
        val n = grid[0].size
        var ans = 0
        for (i in 0 until m) {
            for (j in 0 until n) {
                if (grid[i][j] == 1) {
                    var found = false
                    for (k in 0 until n) if (k != j && grid[i][k] == 1) found = true
                    for (k in 0 until m) if (k != i && grid[k][j] == 1) found = true
                    if (found) ans++
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
    fun countServers(grid: Array<IntArray>): Int {
        val m = grid.size
        val n = grid[0].size
        val row = IntArray(m)
        val col = IntArray(n)
        for (i in 0 until m)
            for (j in 0 until n)
                if (grid[i][j] == 1) { row[i]++; col[j]++ }
        var ans = 0
        for (i in 0 until m)
            for (j in 0 until n)
                if (grid[i][j] == 1 && (row[i] > 1 || col[j] > 1)) ans++
        return ans
    }
}
*/

// Optimized Approach: one pass, answer = total - isolated
class Solution {
    fun countServers(grid: Array<IntArray>): Int {
        val m = grid.size
        val n = grid[0].size
        val rowCnt = IntArray(m)
        val rowCol = IntArray(m)
        val colCnt = IntArray(n)
        var total = 0
        for (i in 0 until m) {
            for (j in 0 until n) {
                if (grid[i][j] == 1) {
                    rowCnt[i]++
                    rowCol[i] += j
                    colCnt[j]++
                    total++
                }
            }
        }
        var isolated = 0
        for (i in 0 until m) {
            if (rowCnt[i] == 1 && colCnt[rowCol[i]] == 1) isolated++
        }
        return total - isolated
    }
}