"""
Brute Force

class Solution(object):
    def minMoves(self, nums):
        moves = 0
        while min(nums) != max(nums):
            nums[nums.index(min(nums))] += 1
            moves += 1
        return moves
"""

"""
Better Approach

class Solution(object):
    def minMoves(self, nums):
        nums.sort()
        moves = 0
        for x in nums:
            moves += nums[-1] - x
        return moves
"""

class Solution(object):
    def minMoves(self, nums):
        mx = total = 0
        for x in nums:
            mx = max(mx, x)
            total += x
        return mx * len(nums) - total