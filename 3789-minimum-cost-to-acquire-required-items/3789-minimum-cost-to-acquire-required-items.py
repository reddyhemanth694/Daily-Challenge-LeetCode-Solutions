"""
Brute Force

class Solution:
    def minimumCost(self, cost1: int, cost2: int, costBoth: int, need1: int, need2: int) -> int:
        best = float('inf')
        for k in range(max(need1, need2) + 1):
            best = min(best, k * costBoth + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2)
        return best
"""

"""
Better Approach

class Solution:
    def minimumCost(self, cost1: int, cost2: int, costBoth: int, need1: int, need2: int) -> int:
        def total(k):
            return k * costBoth + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2

        lo, hi = 0, max(need1, need2)
        while lo < hi:
            mid = (lo + hi) // 2
            if total(mid) <= total(mid + 1):
                hi = mid
            else:
                lo = mid + 1
        return total(lo)
"""

class Solution:
    def minimumCost(self, cost1: int, cost2: int, costBoth: int, need1: int, need2: int) -> int:
        both = min(need1, need2)
        return both * min(costBoth, cost1 + cost2) + (need1 - both) * min(cost1, costBoth) + (need2 - both) * min(cost2, costBoth)