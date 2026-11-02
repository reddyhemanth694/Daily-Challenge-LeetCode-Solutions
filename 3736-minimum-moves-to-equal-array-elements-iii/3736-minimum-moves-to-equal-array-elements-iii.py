"""
Brute Force

class Solution:
    def minMoves(self, nums: List[int]) -> int:
        moves = 0
        while min(nums) != max(nums):
            nums[nums.index(min(nums))] += 1
            moves += 1
        return moves
"""

"""
Better Approach

class Solution:
    def minMoves(self, nums: List[int]) -> int:
        nums.sort()
        moves = 0
        for x in nums:
            moves += nums[-1] - x
        return moves
"""

class Solution:
    def minMoves(self, nums: List[int]) -> int:
        mx = total = 0
        for x in nums:
            mx = max(mx, x)
            total += x
        return mx * len(nums) - total