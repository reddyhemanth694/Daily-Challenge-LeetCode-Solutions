/*
Brute Force

object Solution {
  def minMoves(nums: Array[Int]): Int = {
    var moves = 0
    while (nums.min != nums.max) {
      nums(nums.indexOf(nums.min)) += 1
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
    sorted.map(sorted.last - _).sum
  }
}
*/

object Solution {
  def minMoves(nums: Array[Int]): Int = {
    var mx = 0
    var sum = 0
    for (x <- nums) {
      mx = math.max(mx, x)
      sum += x
    }
    mx * nums.length - sum
  }
}