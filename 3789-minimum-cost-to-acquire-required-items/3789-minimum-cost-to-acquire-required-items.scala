/*
Brute Force

object Solution {
  def minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long = {
    var best = Long.MaxValue
    var k = 0L
    while (k <= math.max(need1, need2)) {
      best = math.min(best, k * costBoth + math.max(0L, need1 - k) * cost1 + math.max(0L, need2 - k) * cost2)
      k += 1
    }
    best
  }
}
*/

/*
Better Approach

object Solution {
  def minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long = {
    def total(k: Long): Long = k * costBoth + math.max(0L, need1 - k) * cost1 + math.max(0L, need2 - k) * cost2
    var lo = 0L
    var hi = math.max(need1, need2).toLong
    while (lo < hi) {
      val mid = (lo + hi) / 2
      if (total(mid) <= total(mid + 1)) hi = mid else lo = mid + 1
    }
    total(lo)
  }
}
*/

object Solution {
  def minimumCost(cost1: Int, cost2: Int, costBoth: Int, need1: Int, need2: Int): Long = {
    val both = math.min(need1, need2).toLong
    both * math.min(costBoth, cost1 + cost2) + (need1 - both) * math.min(cost1, costBoth) + (need2 - both) * math.min(cost2, costBoth)
  }
}