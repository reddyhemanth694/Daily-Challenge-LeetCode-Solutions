"""
Brute Force

class Solution(object):
    def minOperations(self, nums, x, k):
        n = len(nums)

        def window_cost(i):
            w = sorted(nums[i:i + x])
            med = w[x // 2]
            return sum(abs(v - med) for v in w)

        def dfs(i, j):
            if j == 0:
                return 0
            if n - i < j * x:
                return float('inf')
            return min(dfs(i + 1, j), window_cost(i) + dfs(i + x, j - 1))

        return dfs(0, k)
"""

"""
Better Approach

class Solution(object):
    def minOperations(self, nums, x, k):
        n = len(nums)
        cost = []
        for i in range(n - x + 1):
            w = sorted(nums[i:i + x])
            med = w[x // 2]
            cost.append(sum(abs(v - med) for v in w))
        INF = float('inf')
        prev = [0] * (n + 1)
        for _ in range(k):
            cur = [INF] * (n + 1)
            for i in range(x, n + 1):
                cur[i] = min(cur[i - 1], prev[i - x] + cost[i - x])
            prev = cur
        return prev[n]
"""

from heapq import heappush, heappop

class Solution(object):
    def minOperations(self, nums, x, k):
        n = len(nums)
        low, high, delayed = [], [], {}
        size, total = [0, 0], [0, 0]

        def prune(heap, sign):
            while heap and delayed.get(sign * heap[0], 0):
                v = sign * heappop(heap)
                delayed[v] -= 1

        def balance():
            if size[0] > size[1] + 1:
                v = -heappop(low)
                heappush(high, v)
                size[0] -= 1
                size[1] += 1
                total[0] -= v
                total[1] += v
                prune(low, -1)
            elif size[0] < size[1]:
                v = heappop(high)
                heappush(low, -v)
                size[1] -= 1
                size[0] += 1
                total[1] -= v
                total[0] += v
                prune(high, 1)

        def insert(v):
            if not low or v <= -low[0]:
                heappush(low, -v)
                size[0] += 1
                total[0] += v
            else:
                heappush(high, v)
                size[1] += 1
                total[1] += v
            balance()

        def erase(v):
            delayed[v] = delayed.get(v, 0) + 1
            if v <= -low[0]:
                size[0] -= 1
                total[0] -= v
                if v == -low[0]:
                    prune(low, -1)
            else:
                size[1] -= 1
                total[1] -= v
                if v == high[0]:
                    prune(high, 1)
            balance()

        cost = []
        for i in range(n):
            insert(nums[i])
            if i >= x:
                erase(nums[i - x])
            if i >= x - 1:
                med = -low[0]
                cost.append(med * size[0] - total[0] + total[1] - med * size[1])
        INF = float('inf')
        prev = [0] * (n + 1)
        for _ in range(k):
            cur = [INF] * (n + 1)
            for i in range(x, n + 1):
                take = prev[i - x] + cost[i - x]
                cur[i] = cur[i - 1] if cur[i - 1] < take else take
            prev = cur
        return prev[n]