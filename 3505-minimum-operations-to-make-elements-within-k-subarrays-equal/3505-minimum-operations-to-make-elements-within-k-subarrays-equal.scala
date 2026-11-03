/*
Brute Force

object Solution {
  def minOperations(nums: Array[Int], x: Int, k: Int): Long = {
    val n = nums.length
    def windowCost(i: Int): Long = {
      val w = nums.slice(i, i + x).sorted
      val med = w(x / 2).toLong
      w.map(v => math.abs(v - med)).sum
    }
    def dfs(i: Int, j: Int): Long = {
      if (j == 0) 0L
      else if (n - i < j.toLong * x) Long.MaxValue
      else math.min(dfs(i + 1, j), windowCost(i) + dfs(i + x, j - 1))
    }
    dfs(0, k)
  }
}
*/

/*
Better Approach

object Solution {
  def minOperations(nums: Array[Int], x: Int, k: Int): Long = {
    val n = nums.length
    val cost = Array.tabulate(n - x + 1) { i =>
      val w = nums.slice(i, i + x).sorted
      val med = w(x / 2).toLong
      w.map(v => math.abs(v - med)).sum
    }
    val inf = Long.MaxValue / 4
    var prev = new Array[Long](n + 1)
    var cur = new Array[Long](n + 1)
    for (_ <- 1 to k) {
      java.util.Arrays.fill(cur, inf)
      for (i <- x to n) cur(i) = math.min(cur(i - 1), prev(i - x) + cost(i - x))
      val t = prev
      prev = cur
      cur = t
    }
    prev(n)
  }
}
*/

object Solution {
  def minOperations(nums: Array[Int], x: Int, k: Int): Long = {
    val n = nums.length
    val vals = nums.distinct.sorted
    val m = vals.length
    var top = 1
    while (top * 2 <= m) top *= 2
    val idx = nums.map(v => java.util.Arrays.binarySearch(vals, v) + 1)
    val cnt = new Array[Long](m + 1)
    val sum = new Array[Long](m + 1)
    val cost = new Array[Long](n - x + 1)
    def update(i: Int, d: Int): Unit = {
      var p = idx(i)
      while (p <= m) {
        cnt(p) += d
        sum(p) += d.toLong * nums(i)
        p += p & -p
      }
    }
    var total = 0L
    val half = (x + 1) / 2
    for (i <- 0 until n) {
      update(i, 1)
      total += nums(i)
      if (i >= x) {
        update(i - x, -1)
        total -= nums(i - x)
      }
      if (i >= x - 1) {
        var p = 0
        var need = half.toLong
        var lowCnt = 0L
        var lowSum = 0L
        var step = top
        while (step > 0) {
          if (p + step <= m && cnt(p + step) < need) {
            p += step
            need -= cnt(p)
            lowCnt += cnt(p)
            lowSum += sum(p)
          }
          step >>= 1
        }
        val med = vals(p).toLong
        cost(i - x + 1) = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt)
      }
    }
    val inf = Long.MaxValue / 4
    var prev = new Array[Long](n + 1)
    var cur = new Array[Long](n + 1)
    for (_ <- 1 to k) {
      java.util.Arrays.fill(cur, inf)
      for (i <- x to n) cur(i) = math.min(cur(i - 1), prev(i - x) + cost(i - x))
      val t = prev
      prev = cur
      cur = t
    }
    prev(n)
  }
}