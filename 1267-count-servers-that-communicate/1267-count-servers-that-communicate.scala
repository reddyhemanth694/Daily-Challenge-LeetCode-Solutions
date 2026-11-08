/*
Brute Force
object Solution {
    def countServers(grid: Array[Array[Int]]): Int = {
        val m = grid.length
        val n = grid(0).length
        var ans = 0
        for (i <- 0 until m; j <- 0 until n) {
            if (grid(i)(j) == 1) {
                val found = (0 until n).exists(k => k != j && grid(i)(k) == 1) ||
                            (0 until m).exists(k => k != i && grid(k)(j) == 1)
                if (found) ans += 1
            }
        }
        ans
    }
}
*/

/*
Better Approach
object Solution {
    def countServers(grid: Array[Array[Int]]): Int = {
        val m = grid.length
        val n = grid(0).length
        val row = grid.map(_.sum)
        val col = Array.tabulate(n)(j => grid.map(_(j)).sum)
        var ans = 0
        for (i <- 0 until m; j <- 0 until n) {
            if (grid(i)(j) == 1 && (row(i) > 1 || col(j) > 1)) ans += 1
        }
        ans
    }
}
*/

// Optimized Approach: one pass, answer = total - isolated
object Solution {
    def countServers(grid: Array[Array[Int]]): Int = {
        val m = grid.length
        val n = grid(0).length
        val rowCnt = new Array[Int](m)
        val rowCol = new Array[Int](m)
        val colCnt = new Array[Int](n)
        var total = 0
        for (i <- 0 until m; j <- 0 until n) {
            if (grid(i)(j) == 1) {
                rowCnt(i) += 1
                rowCol(i) += j
                colCnt(j) += 1
                total += 1
            }
        }
        var isolated = 0
        for (i <- 0 until m) {
            if (rowCnt(i) == 1 && colCnt(rowCol(i)) == 1) isolated += 1
        }
        total - isolated
    }
}