"""
Brute Force

class Solution(object):
    def minMoves(self, nums):
        moves = 0
        while True:
            mx = nums.index(max(nums))
            if nums[mx] == min(nums):
                return moves
            for i in range(len(nums)):
                if i != mx:
                    nums[i] += 1
            moves += 1
"""

"""
Better Approach

class Solution(object):
    def minMoves(self, nums):
        nums.sort()
        moves = 0
        for x in nums:
            moves += x - nums[0]
        return moves
"""

class Solution(object):
    def minMoves(self, nums):
        mn = min(nums)
        moves = 0
        for x in nums:
            moves += x - mn
        return moves