"""
Brute Force

class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(arr)
        ans = 0
        for i in range(n):
            for j in range(i, n):
                if sum(arr[i:j + 1]) % 2 == 1:
                    ans += 1
        return ans % MOD
"""

"""
Better Approach

class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(arr)
        ans = 0
        for i in range(n):
            s = 0
            for j in range(i, n):
                s += arr[j]
                if s % 2 == 1:
                    ans += 1
        return ans % MOD
"""

class Solution:
    def numOfSubarrays(self, arr: List[int]) -> int:
        MOD = 10**9 + 7
        odd, even, s, ans = 0, 1, 0, 0
        for x in arr:
            s += x
            if s % 2 == 1:
                ans += even
                odd += 1
            else:
                ans += odd
                even += 1
        return ans % MOD