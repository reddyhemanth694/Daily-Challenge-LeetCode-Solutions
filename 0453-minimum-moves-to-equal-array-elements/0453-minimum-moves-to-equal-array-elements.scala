/*
Brute Force

object Solution {
  def minMoves(nums: Array[Int]): Int = {
    var moves = 0
    while (nums.min != nums.max) {
      val mx = nums.indexOf(nums.max)
      for (i <- nums.indices if i != mx) nums(i) += 1
      moves += 1
    }
    moves
  }
}
*/

/*
Better Approach

object Solution {
  def minMoves(nums: Array[Int]): Int = {
    val sorted = nums.sorted
    var moves = 0L
    for (x <- sorted) moves += x.toLong - sorted(0)
    moves.toInt
  }
}
*/

object Solution {
  def minMoves(nums: Array[Int]): Int = {
    val mn = nums.min
    var moves = 0L
    for (x <- nums) moves += x.toLong - mn
    moves.toInt
  }
}