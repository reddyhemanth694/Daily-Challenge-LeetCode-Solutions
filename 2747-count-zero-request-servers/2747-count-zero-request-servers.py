"""
Brute Force

class Solution(object):
    def countServers(self, n, logs, x, queries):
        ans = []
        for q in queries:
            seen = set()
            for s, t in logs:
                if q - x <= t <= q:
                    seen.add(s)
            ans.append(n - len(seen))
        return ans
"""

"""
Better Approach

from bisect import bisect_left, bisect_right

class Solution(object):
    def countServers(self, n, logs, x, queries):
        logs.sort(key=lambda lg: lg[1])
        times = [t for _, t in logs]
        ans = []
        for q in queries:
            lo = bisect_left(times, q - x)
            hi = bisect_right(times, q)
            ans.append(n - len({logs[j][0] for j in range(lo, hi)}))
        return ans
"""

class Solution(object):
    def countServers(self, n, logs, x, queries):
        logs.sort(key=lambda lg: lg[1])
        order = sorted(range(len(queries)), key=lambda i: queries[i])
        cnt = [0] * (n + 1)
        ans = [0] * len(queries)
        m = len(logs)
        l = r = distinct = 0
        for i in order:
            q = queries[i]
            while r < m and logs[r][1] <= q:
                s = logs[r][0]
                if cnt[s] == 0:
                    distinct += 1
                cnt[s] += 1
                r += 1
            while l < r and logs[l][1] < q - x:
                s = logs[l][0]
                cnt[s] -= 1
                if cnt[s] == 0:
                    distinct -= 1
                l += 1
            ans[i] = n - distinct
        return ans