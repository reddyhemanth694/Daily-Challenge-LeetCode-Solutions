/*
Brute Force

object Solution {
  def countServers(n: Int, logs: Array[Array[Int]], x: Int, queries: Array[Int]): Array[Int] = {
    queries.map { q =>
      val seen = new Array[Boolean](n + 1)
      var cnt = 0
      for (lg <- logs) {
        if (lg(1) >= q - x && lg(1) <= q && !seen(lg(0))) {
          seen(lg(0)) = true
          cnt += 1
        }
      }
      n - cnt
    }
  }
}
*/

/*
Better Approach

object Solution {
  def countServers(n: Int, logs: Array[Array[Int]], x: Int, queries: Array[Int]): Array[Int] = {
    val lg = logs.sortBy(_(1))
    val m = lg.length
    val stamp = Array.fill(n + 1)(-1)
    queries.indices.map { i =>
      val q = queries(i)
      var lo = 0
      var hi = m
      while (lo < hi) {
        val mid = (lo + hi) / 2
        if (lg(mid)(1) < q - x) lo = mid + 1 else hi = mid
      }
      var cnt = 0
      var j = lo
      while (j < m && lg(j)(1) <= q) {
        if (stamp(lg(j)(0)) != i) {
          stamp(lg(j)(0)) = i
          cnt += 1
        }
        j += 1
      }
      n - cnt
    }.toArray
  }
}
*/

object Solution {
  def countServers(n: Int, logs: Array[Array[Int]], x: Int, queries: Array[Int]): Array[Int] = {
    val lg = logs.sortBy(_(1))
    val m = lg.length
    val cnt = new Array[Int](n + 1)
    val ans = new Array[Int](queries.length)
    var l = 0
    var r = 0
    var distinct = 0
    for (i <- queries.indices.sortBy(queries(_))) {
      val q = queries(i)
      while (r < m && lg(r)(1) <= q) {
        if (cnt(lg(r)(0)) == 0) distinct += 1
        cnt(lg(r)(0)) += 1
        r += 1
      }
      while (l < r && lg(l)(1) < q - x) {
        cnt(lg(l)(0)) -= 1
        if (cnt(lg(l)(0)) == 0) distinct -= 1
        l += 1
      }
      ans(i) = n - distinct
    }
    ans
  }
}