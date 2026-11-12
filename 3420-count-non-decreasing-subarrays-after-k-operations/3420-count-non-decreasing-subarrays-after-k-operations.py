"""
Brute Force

class Solution:
    def countNonDecreasingSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        ans = 0
        for l in range(n):
            mx = cost = 0
            for r in range(l, n):
                mx = max(mx, nums[r])
                cost += mx - nums[r]
                if cost > k:
                    break
                ans += 1
        return ans
"""

"""
Better Approach

class Solution:
    def countNonDecreasingSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        lg = n.bit_length()
        pre = [0] * (n + 1)
        for i, v in enumerate(nums):
            pre[i + 1] = pre[i] + v
        nxt = [n] * (n + 1)
        st = []
        for i in range(n - 1, -1, -1):
            while st and nums[st[-1]] <= nums[i]:
                st.pop()
            nxt[i] = st[-1] if st else n
            st.append(i)
        up = [nxt]
        sm = [[nums[i] * (nxt[i] - i) - (pre[nxt[i]] - pre[i]) for i in range(n)] + [0]]
        for _ in range(1, lg):
            pu, ps = up[-1], sm[-1]
            up.append([pu[pu[i]] for i in range(n + 1)])
            sm.append([ps[i] + ps[pu[i]] for i in range(n + 1)])
        ans = 0
        for l in range(n):
            cur, acc = l, 0
            for j in range(lg - 1, -1, -1):
                if cur < n and acc + sm[j][cur] <= k:
                    acc += sm[j][cur]
                    cur = up[j][cur]
            if cur == n:
                ans += n - l
                continue
            lo, hi = cur, nxt[cur] - 1
            while lo < hi:
                mid = (lo + hi + 1) // 2
                if acc + nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k:
                    lo = mid
                else:
                    hi = mid - 1
            ans += lo - l + 1
        return ans
"""

from collections import deque

class Solution:
    def countNonDecreasingSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dq = deque()
        ans = cost = 0
        r = n - 1
        for l in range(n - 1, -1, -1):
            while dq and nums[dq[0]] <= nums[l]:
                i = dq.popleft()
                end = dq[0] if dq else r + 1
                cost += (nums[l] - nums[i]) * (end - i)
            dq.appendleft(l)
            while cost > k:
                cost -= nums[dq[-1]] - nums[r]
                if dq[-1] == r:
                    dq.pop()
                r -= 1
            ans += r - l + 1
        return ans