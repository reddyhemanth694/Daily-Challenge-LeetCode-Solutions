/*
Brute Force

object Solution {
  def minChanges(s: String): Int = {
    val n = s.length
    def solve(i: Int): Int = {
      if (i == n) 0
      else {
        var best = n
        var ones = 0
        for (j <- i until n) {
          if (s(j) == '1') ones += 1
          val len = j - i + 1
          if (len % 2 == 0) best = math.min(best, math.min(ones, len - ones) + solve(j + 1))
        }
        best
      }
    }
    solve(0)
  }
}
*/

/*
Better Approach

object Solution {
  def minChanges(s: String): Int = {
    val n = s.length
    val dp = Array.fill(n + 1)(n)
    dp(0) = 0
    for (i <- 0 until n by 2) {
      var ones = 0
      for (j <- i until n) {
        if (s(j) == '1') ones += 1
        val len = j - i + 1
        if (len % 2 == 0) dp(j + 1) = math.min(dp(j + 1), dp(i) + math.min(ones, len - ones))
      }
    }
    dp(n)
  }
}
*/

object Solution {
  def minChanges(s: String): Int = {
    (0 until s.length by 2).count(i => s(i) != s(i + 1))
  }
}