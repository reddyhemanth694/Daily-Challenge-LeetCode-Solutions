/*
Brute Force

object Solution {
  def longestMonotonicSubarray(nums: Array[Int]): Int = {
    val n = nums.length
    var res = 1
    for (i <- 0 until n) {
      var inc = 1
      var dec = 1
      while (i + inc < n && nums(i + inc) > nums(i + inc - 1)) inc += 1
      while (i + dec < n && nums(i + dec) < nums(i + dec - 1)) dec += 1
      res = res max inc max dec
    }
    res
  }
}
*/

/*
Better Approach

object Solution {
  def longestMonotonicSubarray(nums: Array[Int]): Int = {
    var res = 1
    var len = 1
    for (i <- 1 until nums.length) {
      len = if (nums(i) > nums(i - 1)) len + 1 else 1
      res = res max len
    }
    len = 1
    for (i <- 1 until nums.length) {
      len = if (nums(i) < nums(i - 1)) len + 1 else 1
      res = res max len
    }
    res
  }
}
*/

object Solution {
  def longestMonotonicSubarray(nums: Array[Int]): Int = {
    var res = 1
    var inc = 1
    var dec = 1
    for (i <- 1 until nums.length) {
      inc = if (nums(i) > nums(i - 1)) inc + 1 else 1
      dec = if (nums(i) < nums(i - 1)) dec + 1 else 1
      res = res max inc max dec
    }
    res
  }
}