/*
Brute Force

class Solution {
  int minMoves(List<int> nums) {
    int moves = 0;
    while (true) {
      int mn = 0, mx = 0;
      for (int i = 1; i < nums.length; i++) {
        if (nums[i] < nums[mn]) mn = i;
        if (nums[i] > nums[mx]) mx = i;
      }
      if (nums[mn] == nums[mx]) return moves;
      nums[mn]++;
      moves++;
    }
  }
}
*/

/*
Better Approach

class Solution {
  int minMoves(List<int> nums) {
    nums.sort();
    int moves = 0;
    for (int x in nums) moves += nums.last - x;
    return moves;
  }
}
*/

class Solution {
  int minMoves(List<int> nums) {
    int mx = 0, sum = 0;
    for (int x in nums) {
      if (x > mx) mx = x;
      sum += x;
    }
    return mx * nums.length - sum;
  }
}