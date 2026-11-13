"""
Brute Force

class Solution:
    def minimumSumSubarray(self, nums: List[int], l: int, r: int) -> int:
        n = len(nums)
        ans = float('inf')
        for i in range(n):
            for length in range(l, r + 1):
                if i + length > n:
                    break
                s = sum(nums[i:i + length])
                if s > 0:
                    ans = min(ans, s)
        return -1 if ans == float('inf') else ans
"""

"""
Better Approach

class Solution:
    def minimumSumSubarray(self, nums: List[int], l: int, r: int) -> int:
        n = len(nums)
        ans = float('inf')
        for i in range(n):
            s = 0
            for j in range(i, min(n, i + r)):
                s += nums[j]
                if j - i + 1 >= l and s > 0:
                    ans = min(ans, s)
        return -1 if ans == float('inf') else ans
"""

from bisect import bisect_left, insort

class Solution:
    def minimumSumSubarray(self, nums: List[int], l: int, r: int) -> int:
        n = len(nums)
        pre = [0] * (n + 1)
        for i, v in enumerate(nums):
            pre[i + 1] = pre[i] + v
        win = []
        ans = float('inf')
        for j in range(l, n + 1):
            insort(win, pre[j - l])
            if j - r - 1 >= 0:
                win.pop(bisect_left(win, pre[j - r - 1]))
            idx = bisect_left(win, pre[j])
            if idx:
                ans = min(ans, pre[j] - win[idx - 1])
        return -1 if ans == float('inf') else ans