"""
Brute Force

class Solution:
    def sumAndMultiply(self, s: str, queries: List[List[int]]) -> List[int]:
        MOD = 10**9 + 7
        ans = []
        for l, r in queries:
            x = total = 0
            for c in s[l:r + 1]:
                d = int(c)
                if d:
                    x = (x * 10 + d) % MOD
                    total += d
            ans.append(x * total % MOD)
        return ans
"""

"""
Better Approach

class Solution:
    def sumAndMultiply(self, s: str, queries: List[List[int]]) -> List[int]:
        MOD = 10**9 + 7
        m = len(s)
        pre, cnt, total = [0] * (m + 1), [0] * (m + 1), [0] * (m + 1)
        for i, c in enumerate(s):
            d = int(c)
            pre[i + 1] = (pre[i] * 10 + d) % MOD if d else pre[i]
            cnt[i + 1] = cnt[i] + (d > 0)
            total[i + 1] = total[i] + d
        ans = []
        for l, r in queries:
            r += 1
            x = (pre[r] - pre[l] * pow(10, cnt[r] - cnt[l], MOD)) % MOD
            ans.append(x * (total[r] - total[l]) % MOD)
        return ans
"""

class Solution:
    def sumAndMultiply(self, s: str, queries: List[List[int]]) -> List[int]:
        MOD = 10**9 + 7
        m = len(s)
        pre, cnt, total, pw = [0] * (m + 1), [0] * (m + 1), [0] * (m + 1), [1] * (m + 1)
        for i, c in enumerate(s):
            d = int(c)
            pw[i + 1] = pw[i] * 10 % MOD
            pre[i + 1] = (pre[i] * 10 + d) % MOD if d else pre[i]
            cnt[i + 1] = cnt[i] + (d > 0)
            total[i + 1] = total[i] + d
        ans = []
        for l, r in queries:
            r += 1
            x = (pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD
            ans.append(x * (total[r] - total[l]) % MOD)
        return ans