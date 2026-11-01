"""
Brute Force

class Solution:
    def sumAndMultiply(self, n: int) -> int:
        t = str(n).replace("0", "")
        if not t:
            return 0
        return int(t) * sum(int(c) for c in t)
"""

"""
Better Approach

class Solution:
    def sumAndMultiply(self, n: int) -> int:
        digits = []
        while n:
            digits.append(n % 10)
            n //= 10
        x = total = 0
        for d in reversed(digits):
            if d:
                x = x * 10 + d
                total += d
        return x * total
"""

class Solution:
    def sumAndMultiply(self, n: int) -> int:
        x = total = 0
        p = 1
        while n:
            d = n % 10
            if d:
                x += d * p
                total += d
                p *= 10
            n //= 10
        return x * total