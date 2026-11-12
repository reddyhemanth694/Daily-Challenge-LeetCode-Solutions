"""
Brute Force

class Solution(object):
    def longestMonotonicSubarray(self, nums):
        n = len(nums)
        res = 1
        for i in range(n):
            inc = dec = 1
            while i + inc < n and nums[i + inc] > nums[i + inc - 1]:
                inc += 1
            while i + dec < n and nums[i + dec] < nums[i + dec - 1]:
                dec += 1
            res = max(res, inc, dec)
        return res
"""

"""
Better Approach

class Solution(object):
    def longestMonotonicSubarray(self, nums):
        res = length = 1
        for i in range(1, len(nums)):
            length = length + 1 if nums[i] > nums[i - 1] else 1
            res = max(res, length)
        length = 1
        for i in range(1, len(nums)):
            length = length + 1 if nums[i] < nums[i - 1] else 1
            res = max(res, length)
        return res
"""

class Solution(object):
    def longestMonotonicSubarray(self, nums):
        res = inc = dec = 1
        for i in range(1, len(nums)):
            inc = inc + 1 if nums[i] > nums[i - 1] else 1
            dec = dec + 1 if nums[i] < nums[i - 1] else 1
            res = max(res, inc, dec)
        return res