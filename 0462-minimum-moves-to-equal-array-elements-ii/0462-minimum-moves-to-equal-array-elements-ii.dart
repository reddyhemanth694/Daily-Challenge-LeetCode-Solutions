/*
Brute Force

class Solution {
  int minMoves2(List<int> nums) {
    int best = -1;
    for (int x in nums) {
      int cost = 0;
      for (int a in nums) cost += (a - x).abs();
      if (best == -1 || cost < best) best = cost;
    }
    return best;
  }
}
*/

/*
Better Approach

class Solution {
  int minMoves2(List<int> nums) {
    nums.sort();
    int median = nums[nums.length ~/ 2];
    int moves = 0;
    for (int a in nums) moves += (a - median).abs();
    return moves;
  }
}
*/

class Solution {
  int minMoves2(List<int> nums) {
    int k = nums.length ~/ 2, lo = 0, hi = nums.length - 1, median = 0;
    while (true) {
      int pivot = nums[(lo + hi) ~/ 2];
      int lt = lo, i = lo, gt = hi;
      while (i <= gt) {
        if (nums[i] < pivot) {
          int t = nums[lt];
          nums[lt++] = nums[i];
          nums[i++] = t;
        } else if (nums[i] > pivot) {
          int t = nums[gt];
          nums[gt--] = nums[i];
          nums[i] = t;
        } else {
          i++;
        }
      }
      if (k < lt) {
        hi = lt - 1;
      } else if (k > gt) {
        lo = gt + 1;
      } else {
        median = pivot;
        break;
      }
    }
    int moves = 0;
    for (int a in nums) moves += (a - median).abs();
    return moves;
  }
}