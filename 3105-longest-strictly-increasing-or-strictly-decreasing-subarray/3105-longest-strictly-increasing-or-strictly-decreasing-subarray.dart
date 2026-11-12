/*
Brute Force

class Solution {
  int longestMonotonicSubarray(List<int> nums) {
    int n = nums.length, res = 1;
    for (int i = 0; i < n; i++) {
      int inc = 1, dec = 1;
      while (i + inc < n && nums[i + inc] > nums[i + inc - 1]) inc++;
      while (i + dec < n && nums[i + dec] < nums[i + dec - 1]) dec++;
      if (inc > res) res = inc;
      if (dec > res) res = dec;
    }
    return res;
  }
}
*/

/*
Better Approach

class Solution {
  int longestMonotonicSubarray(List<int> nums) {
    int res = 1, len = 1;
    for (int i = 1; i < nums.length; i++) {
      len = nums[i] > nums[i - 1] ? len + 1 : 1;
      if (len > res) res = len;
    }
    len = 1;
    for (int i = 1; i < nums.length; i++) {
      len = nums[i] < nums[i - 1] ? len + 1 : 1;
      if (len > res) res = len;
    }
    return res;
  }
}
*/

class Solution {
  int longestMonotonicSubarray(List<int> nums) {
    int res = 1, inc = 1, dec = 1;
    for (int i = 1; i < nums.length; i++) {
      inc = nums[i] > nums[i - 1] ? inc + 1 : 1;
      dec = nums[i] < nums[i - 1] ? dec + 1 : 1;
      if (inc > res) res = inc;
      if (dec > res) res = dec;
    }
    return res;
  }
}