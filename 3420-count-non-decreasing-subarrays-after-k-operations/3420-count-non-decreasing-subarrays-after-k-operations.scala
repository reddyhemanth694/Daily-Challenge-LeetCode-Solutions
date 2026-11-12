/*
Brute Force

object Solution {
  def countNonDecreasingSubarrays(nums: Array[Int], k: Int): Long = {
    val n = nums.length
    var ans = 0L
    for (l <- 0 until n) {
      var mx = 0
      var cost = 0L
      var r = l
      while (r < n && { mx = math.max(mx, nums(r)); cost += mx - nums(r); cost <= k }) {
        ans += 1
        r += 1
      }
    }
    ans
  }
}
*/

/*
Better Approach

object Solution {
  def countNonDecreasingSubarrays(nums: Array[Int], k: Int): Long = {
    val n = nums.length
    var lg = 1
    while ((1 << lg) <= n) lg += 1
    val pre = new Array[Long](n + 1)
    for (i <- 0 until n) pre(i + 1) = pre(i) + nums(i)
    val up = Array.fill(lg, n + 1)(n)
    val sum = Array.ofDim[Long](lg, n + 1)
    val st = new Array[Int](n)
    var top = 0
    for (i <- n - 1 to 0 by -1) {
      while (top > 0 && nums(st(top - 1)) <= nums(i)) top -= 1
      val nx = if (top > 0) st(top - 1) else n
      st(top) = i
      top += 1
      up(0)(i) = nx
      sum(0)(i) = nums(i).toLong * (nx - i) - (pre(nx) - pre(i))
    }
    for (j <- 1 until lg; i <- 0 to n) {
      up(j)(i) = up(j - 1)(up(j - 1)(i))
      sum(j)(i) = sum(j - 1)(i) + sum(j - 1)(up(j - 1)(i))
    }
    var ans = 0L
    for (l <- 0 until n) {
      var cur = l
      var acc = 0L
      for (j <- lg - 1 to 0 by -1) {
        if (cur < n && acc + sum(j)(cur) <= k) {
          acc += sum(j)(cur)
          cur = up(j)(cur)
        }
      }
      if (cur == n) ans += n - l
      else {
        var lo = cur
        var hi = up(0)(cur) - 1
        while (lo < hi) {
          val mid = (lo + hi + 1) / 2
          if (acc + nums(cur).toLong * (mid - cur + 1) - (pre(mid + 1) - pre(cur)) <= k) lo = mid else hi = mid - 1
        }
        ans += lo - l + 1
      }
    }
    ans
  }
}
*/

object Solution {
  def countNonDecreasingSubarrays(nums: Array[Int], k: Int): Long = {
    val n = nums.length
    val dq = new Array[Int](n)
    var head = n
    var tail = n
    var r = n - 1
    var ans = 0L
    var cost = 0L
    for (l <- n - 1 to 0 by -1) {
      while (head < tail && nums(dq(head)) <= nums(l)) {
        val i = dq(head)
        head += 1
        val end = if (head < tail) dq(head) else r + 1
        cost += (nums(l) - nums(i)).toLong * (end - i)
      }
      head -= 1
      dq(head) = l
      while (cost > k) {
        cost -= nums(dq(tail - 1)) - nums(r)
        if (dq(tail - 1) == r) tail -= 1
        r -= 1
      }
      ans += r - l + 1
    }
    ans
  }
}