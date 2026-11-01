/*
Brute Force

class Solution {
  int minMoves(List<int> nums) {
    int moves = 0;
    while (true) {
      int mx = 0;
      bool same = true;
      for (int i = 1; i < nums.length; i++) {
        if (nums[i] != nums[0]) same = false;
        if (nums[i] > nums[mx]) mx = i;
      }
      if (same) return moves;
      for (int i = 0; i < nums.length; i++) {
        if (i != mx) nums[i]++;
      }
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
    for (int x in nums) moves += x - nums[0];
    return moves;
  }
}
*/

class Solution {
  int minMoves(List<int> nums) {
    int mn = nums[0];
    for (int x in nums) {
      if (x < mn) mn = x;
    }
    int moves = 0;
    for (int x in nums) moves += x - mn;
    return moves;
  }
}