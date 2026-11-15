/*
Brute Force

object Solution {
  def numOfSubarrays(arr: Array[Int]): Int = {
    val mod = 1000000007
    val n = arr.length
    var ans = 0
    for (i <- 0 until n; j <- i until n) {
      var sum = 0
      for (k <- i to j) sum += arr(k)
      if (sum % 2 == 1) ans = (ans + 1) % mod
    }
    ans
  }
}
*/

/*
Better Approach

object Solution {
  def numOfSubarrays(arr: Array[Int]): Int = {
    val mod = 1000000007
    val n = arr.length
    var ans = 0
    for (i <- 0 until n) {
      var sum = 0
      for (j <- i until n) {
        sum += arr(j)
        if (sum % 2 == 1) ans = (ans + 1) % mod
      }
    }
    ans
  }
}
*/

object Solution {
  def numOfSubarrays(arr: Array[Int]): Int = {
    val mod = 1000000007
    var odd = 0
    var even = 1
    var sum = 0
    var ans = 0
    for (x <- arr) {
      sum += x
      if (sum % 2 == 1) {
        ans = (ans + even) % mod
        odd += 1
      } else {
        ans = (ans + odd) % mod
        even += 1
      }
    }
    ans
  }
}