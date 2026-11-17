"""
Brute Force

class Solution(object):
    def minChanges(self, s):
        n = len(s)

        def solve(i):
            if i == n:
                return 0
            best = n
            ones = 0
            for j in range(i, n):
                if s[j] == '1':
                    ones += 1
                length = j - i + 1
                if length % 2 == 0:
                    best = min(best, min(ones, length - ones) + solve(j + 1))
            return best

        return solve(0)
"""

"""
Better Approach

class Solution(object):
    def minChanges(self, s):
        n = len(s)
        dp = [n] * (n + 1)
        dp[0] = 0
        for i in range(0, n, 2):
            ones = 0
            for j in range(i, n):
                if s[j] == '1':
                    ones += 1
                length = j - i + 1
                if length % 2 == 0:
                    dp[j + 1] = min(dp[j + 1], dp[i] + min(ones, length - ones))
        return dp[n]
"""

class Solution(object):
    def minChanges(self, s):
        ans = 0
        for i in range(0, len(s), 2):
            if s[i] != s[i + 1]:
                ans += 1
        return ans