"""
Brute Force

class Solution:
    def minMoves2(self, nums: List[int]) -> int:
        best = float('inf')
        for x in nums:
            cost = 0
            for a in nums:
                cost += abs(a - x)
            best = min(best, cost)
        return best
"""

"""
Better Approach

class Solution:
    def minMoves2(self, nums: List[int]) -> int:
        nums.sort()
        median = nums[len(nums) // 2]
        return sum(abs(a - median) for a in nums)
"""

import random

class Solution:
    def minMoves2(self, nums: List[int]) -> int:
        arr, k = nums, len(nums) // 2
        while True:
            pivot = random.choice(arr)
            less = [x for x in arr if x < pivot]
            greater = [x for x in arr if x > pivot]
            equal = len(arr) - len(less) - len(greater)
            if k < len(less):
                arr = less
            elif k < len(less) + equal:
                median = pivot
                break
            else:
                k -= len(less) + equal
                arr = greater
        return sum(abs(a - median) for a in nums)