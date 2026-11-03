/*
Brute Force

public class Solution {
    int n, x;
    int[] a;

    long WindowCost(int i) {
        int[] w = new int[x];
        Array.Copy(a, i, w, 0, x);
        Array.Sort(w);
        long med = w[x / 2], cost = 0;
        foreach (int v in w) cost += Math.Abs(v - med);
        return cost;
    }

    long Dfs(int i, int j) {
        if (j == 0) return 0;
        if (n - i < (long)j * x) return long.MaxValue;
        long skip = Dfs(i + 1, j);
        long take = WindowCost(i) + Dfs(i + x, j - 1);
        return Math.Min(skip, take);
    }

    public long MinOperations(int[] nums, int x, int k) {
        a = nums;
        n = nums.Length;
        this.x = x;
        return Dfs(0, k);
    }
}
*/

/*
Better Approach

public class Solution {
    public long MinOperations(int[] nums, int x, int k) {
        int n = nums.Length;
        long[] cost = new long[n - x + 1];
        int[] w = new int[x];
        for (int i = 0; i + x <= n; i++) {
            Array.Copy(nums, i, w, 0, x);
            Array.Sort(w);
            long med = w[x / 2];
            foreach (int v in w) cost[i] += Math.Abs(v - med);
        }
        const long INF = long.MaxValue / 4;
        long[] prev = new long[n + 1], cur = new long[n + 1];
        for (int j = 1; j <= k; j++) {
            Array.Fill(cur, INF);
            for (int i = x; i <= n; i++) cur[i] = Math.Min(cur[i - 1], prev[i - x] + cost[i - x]);
            (prev, cur) = (cur, prev);
        }
        return prev[n];
    }
}
*/

public class Solution {
    public long MinOperations(int[] nums, int x, int k) {
        int n = nums.Length;
        int[] sorted = (int[])nums.Clone();
        Array.Sort(sorted);
        int m = 0;
        for (int i = 0; i < n; i++)
            if (i == 0 || sorted[i] != sorted[i - 1]) sorted[m++] = sorted[i];
        int top = 1;
        while (top * 2 <= m) top *= 2;
        int[] idx = new int[n];
        for (int i = 0; i < n; i++) idx[i] = Array.BinarySearch(sorted, 0, m, nums[i]) + 1;
        long[] cnt = new long[m + 1], sum = new long[m + 1], cost = new long[n - x + 1];
        long total = 0;
        int half = (x + 1) / 2;
        for (int i = 0; i < n; i++) {
            for (int p = idx[i]; p <= m; p += p & -p) {
                cnt[p]++;
                sum[p] += nums[i];
            }
            total += nums[i];
            if (i >= x) {
                for (int p = idx[i - x]; p <= m; p += p & -p) {
                    cnt[p]--;
                    sum[p] -= nums[i - x];
                }
                total -= nums[i - x];
            }
            if (i >= x - 1) {
                int pos = 0;
                long need = half, lowCnt = 0, lowSum = 0;
                for (int step = top; step > 0; step >>= 1) {
                    if (pos + step <= m && cnt[pos + step] < need) {
                        pos += step;
                        need -= cnt[pos];
                        lowCnt += cnt[pos];
                        lowSum += sum[pos];
                    }
                }
                long med = sorted[pos];
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
            }
        }
        const long INF = long.MaxValue / 4;
        long[] prev = new long[n + 1], cur = new long[n + 1];
        for (int j = 1; j <= k; j++) {
            Array.Fill(cur, INF);
            for (int i = x; i <= n; i++) cur[i] = Math.Min(cur[i - 1], prev[i - x] + cost[i - x]);
            long[] t = prev;
            prev = cur;
            cur = t;
        }
        return prev[n];
    }
}