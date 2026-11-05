/*
Brute Force

object Solution {
  def findTheDistanceValue(arr1: Array[Int], arr2: Array[Int], d: Int): Int = {
    arr1.count(a => arr2.forall(b => math.abs(a - b) > d))
  }
}
*/

/*
Better Approach

object Solution {
  def findTheDistanceValue(arr1: Array[Int], arr2: Array[Int], d: Int): Int = {
    val b = arr2.sorted
    arr1.count { a =>
      var lo = 0
      var hi = b.length
      while (lo < hi) {
        val mid = (lo + hi) / 2
        if (b(mid) < a - d) lo = mid + 1 else hi = mid
      }
      lo == b.length || b(lo) > a + d
    }
  }
}
*/

object Solution {
  def findTheDistanceValue(arr1: Array[Int], arr2: Array[Int], d: Int): Int = {
    val pre = new Array[Int](2202)
    for (v <- arr2) pre(v + 1101) += 1
    for (i <- 1 until 2202) pre(i) += pre(i - 1)
    arr1.count(a => pre(a + d + 1101) == pre(a - d + 1100))
  }
}