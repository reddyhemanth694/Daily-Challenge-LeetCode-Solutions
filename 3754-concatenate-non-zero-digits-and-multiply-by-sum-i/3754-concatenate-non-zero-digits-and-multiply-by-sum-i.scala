/*
Brute Force

object Solution {
  def sumAndMultiply(n: Int): Long = {
    val t = n.toString.filter(_ != '0')
    if (t.isEmpty) 0L else t.toLong * t.map(_ - '0').sum
  }
}
*/

/*
Better Approach

object Solution {
  def sumAndMultiply(n: Int): Long = {
    val digits = scala.collection.mutable.ArrayBuffer[Int]()
    var m = n
    while (m > 0) {
      digits += m % 10
      m /= 10
    }
    var x = 0L
    var sum = 0L
    for (d <- digits.reverseIterator if d != 0) {
      x = x * 10 + d
      sum += d
    }
    x * sum
  }
}
*/

object Solution {
  def sumAndMultiply(n: Int): Long = {
    var m = n
    var x = 0L
    var sum = 0L
    var p = 1L
    while (m > 0) {
      val d = m % 10
      if (d != 0) {
        x += d * p
        sum += d
        p *= 10
      }
      m /= 10
    }
    x * sum
  }
}