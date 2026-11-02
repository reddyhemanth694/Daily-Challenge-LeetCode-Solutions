/*
Brute Force

object Solution {
  def minMoves2(nums: Array[Int]): Int = {
    nums.map(x => nums.map(a => math.abs(a.toLong - x)).sum).min.toInt
  }
}
*/

/*
Better Approach

object Solution {
  def minMoves2(nums: Array[Int]): Int = {
    val sorted = nums.sorted
    val median = sorted(sorted.length / 2).toLong
    sorted.map(a => math.abs(a - median)).sum.toInt
  }
}
*/

object Solution {
  def minMoves2(nums: Array[Int]): Int = {
    val a = nums.clone()
    val k = a.length / 2
    var lo = 0
    var hi = a.length - 1
    var median = 0L
    var found = false
    while (!found) {
      val pivot = a(lo + scala.util.Random.nextInt(hi - lo + 1))
      var lt = lo
      var i = lo
      var gt = hi
      while (i <= gt) {
        if (a(i) < pivot) {
          val t = a(lt); a(lt) = a(i); a(i) = t
          lt += 1
          i += 1
        } else if (a(i) > pivot) {
          val t = a(gt); a(gt) = a(i); a(i) = t
          gt -= 1
        } else {
          i += 1
        }
      }
      if (k < lt) hi = lt - 1
      else if (k > gt) lo = gt + 1
      else {
        median = pivot
        found = true
      }
    }
    nums.foldLeft(0L)((moves, x) => moves + math.abs(x - median)).toInt
  }
}