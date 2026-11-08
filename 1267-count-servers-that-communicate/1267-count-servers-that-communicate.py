# Brute Force
# class Solution:
#     def countServers(self, grid: List[List[int]]) -> int:
#         m, n = len(grid), len(grid[0])
#         ans = 0
#         for i in range(m):
#             for j in range(n):
#                 if grid[i][j] == 1:
#                     if any(grid[i][k] == 1 for k in range(n) if k != j) or \
#                        any(grid[k][j] == 1 for k in range(m) if k != i):
#                         ans += 1
#         return ans

# Better Approach
# class Solution:
#     def countServers(self, grid: List[List[int]]) -> int:
#         row = [sum(r) for r in grid]
#         col = [sum(c) for c in zip(*grid)]
#         ans = 0
#         for i in range(len(grid)):
#             for j in range(len(grid[0])):
#                 if grid[i][j] == 1 and (row[i] > 1 or col[j] > 1):
#                     ans += 1
#         return ans

# Optimized Approach: one pass, answer = total - isolated
class Solution:
    def countServers(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        row_cnt = [0] * m
        row_col = [0] * m
        col_cnt = [0] * n
        total = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    row_cnt[i] += 1
                    row_col[i] += j
                    col_cnt[j] += 1
                    total += 1
        isolated = 0
        for i in range(m):
            if row_cnt[i] == 1 and col_cnt[row_col[i]] == 1:
                isolated += 1
        return total - isolated