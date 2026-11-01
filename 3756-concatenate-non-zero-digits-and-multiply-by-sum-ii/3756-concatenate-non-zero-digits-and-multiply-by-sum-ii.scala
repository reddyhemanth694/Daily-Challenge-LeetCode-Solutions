/*
Brute Force

object Solution {
  def sumAndMultiply(s: String, queries: Array[Array[Int]]): Array[Int] = {
    val mod = 1000000007L
    queries.map { q =>
      var x = 0L
      var sum = 0L
      for (i <- q(0) to q(1)) {
        val d = s(i) - '0'
        if (d != 0) {
          x = (x * 10 + d) % mod
          sum += d
        }
      }
      (x * sum % mod).toInt
    }
  }
}
*/

/*
Better Approach

object Solution {
  val mod = 1000000007L

  def power(base: Long, exp: Int): Long = {
    var b = base
    var e = exp
    var r = 1L
    while (e > 0) {
      if ((e & 1) == 1) r = r * b % mod
      b = b * b % mod
      e >>= 1
    }
    r
  }

  def sumAndMultiply(s: String, queries: Array[Array[Int]]): Array[Int] = {
    val m = s.length
    val pre = new Array[Long](m + 1)
    val cnt = new Array[Int](m + 1)
    val sum = new Array[Long](m + 1)
    for (i <- 0 until m) {
      val d = s(i) - '0'
      pre(i + 1) = if (d != 0) (pre(i) * 10 + d) % mod else pre(i)
      cnt(i + 1) = cnt(i) + (if (d != 0) 1 else 0)
      sum(i + 1) = sum(i) + d
    }
    queries.map { q =>
      val (l, r) = (q(0), q(1) + 1)
      val x = ((pre(r) - pre(l) * power(10, cnt(r) - cnt(l))) % mod + mod) % mod
      (x * (sum(r) - sum(l)) % mod).toInt
    }
  }
}
*/

object Solution {
  def sumAndMultiply(s: String, queries: Array[Array[Int]]): Array[Int] = {
    val mod = 1000000007L
    val m = s.length
    val pre = new Array[Long](m + 1)
    val pw = Array.fill(m + 1)(1L)
    val cnt = new Array[Int](m + 1)
    val sum = new Array[Long](m + 1)
    for (i <- 0 until m) {
      val d = s(i) - '0'
      pw(i + 1) = pw(i) * 10 % mod
      pre(i + 1) = if (d != 0) (pre(i) * 10 + d) % mod else pre(i)
      cnt(i + 1) = cnt(i) + (if (d != 0) 1 else 0)
      sum(i + 1) = sum(i) + d
    }
    queries.map { q =>
      val (l, r) = (q(0), q(1) + 1)
      val x = ((pre(r) - pre(l) * pw(cnt(r) - cnt(l))) % mod + mod) % mod
      (x * (sum(r) - sum(l)) % mod).toInt
    }
  }
}