"""
Brute Force

class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: List[int], d: int) -> int:
        ans = 0
        for a in arr1:
            if all(abs(a - b) > d for b in arr2):
                ans += 1
        return ans
"""

"""
Better Approach

from bisect import bisect_left

class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: List[int], d: int) -> int:
        arr2.sort()
        ans = 0
        for a in arr1:
            i = bisect_left(arr2, a - d)
            if i == len(arr2) or arr2[i] > a + d:
                ans += 1
        return ans
"""

class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: List[int], d: int) -> int:
        pre = [0] * 2202
        for v in arr2:
            pre[v + 1101] += 1
        for i in range(1, 2202):
            pre[i] += pre[i - 1]
        return sum(1 for a in arr1 if pre[a + d + 1101] == pre[a - d + 1100])