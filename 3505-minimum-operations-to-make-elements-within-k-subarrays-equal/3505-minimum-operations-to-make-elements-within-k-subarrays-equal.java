/*
Brute Force

class Solution {
    int n, x;
    int[] a;

    long windowCost(int i) {
        int[] w = Arrays.copyOfRange(a, i, i + x);
        Arrays.sort(w);
        long med = w[x / 2], cost = 0;
        for (int v : w) cost += Math.abs(v - med);
        return cost;
    }

    long dfs(int i, int j) {
        if (j == 0) return 0;
        if (n - i < (long) j * x) return Long.MAX_VALUE;
        long skip = dfs(i + 1, j);
        long take = windowCost(i) + dfs(i + x, j - 1);
        return Math.min(skip, take);
    }

    public long minOperations(int[] nums, int x, int k) {
        a = nums;
        n = nums.length;
        this.x = x;
        return dfs(0, k);
    }
}
*/

/*
Better Approach

class Solution {
    public long minOperations(int[] nums, int x, int k) {
        int n = nums.length;
        long[] cost = new long[n - x + 1];
        for (int i = 0; i + x <= n; i++) {
            int[] w = Arrays.copyOfRange(nums, i, i + x);
            Arrays.sort(w);
            long med = w[x / 2];
            for (int v : w) cost[i] += Math.abs(v - med);
        }
        final long INF = Long.MAX_VALUE / 4;
        long[] prev = new long[n + 1], cur = new long[n + 1];
        for (int j = 1; j <= k; j++) {
            Arrays.fill(cur, INF);
            for (int i = x; i <= n; i++) cur[i] = Math.min(cur[i - 1], prev[i - x] + cost[i - x]);
            long[] t = prev;
            prev = cur;
            cur = t;
        }
        return prev[n];
    }
}
*/

class Solution {
    public long minOperations(int[] nums, int x, int k) {
        int n = nums.length;
        int[] sorted = nums.clone();
        Arrays.sort(sorted);
        int m = 0;
        for (int i = 0; i < n; i++)
            if (i == 0 || sorted[i] != sorted[i - 1]) sorted[m++] = sorted[i];
        int[] vals = Arrays.copyOf(sorted, m);
        int top = 1;
        while (top * 2 <= m) top *= 2;
        int[] idx = new int[n];
        for (int i = 0; i < n; i++) idx[i] = Arrays.binarySearch(vals, nums[i]) + 1;
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
                long med = vals[pos];
                cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
            }
        }
        final long INF = Long.MAX_VALUE / 4;
        long[] prev = new long[n + 1], cur = new long[n + 1];
        for (int j = 1; j <= k; j++) {
            Arrays.fill(cur, INF);
            for (int i = x; i <= n; i++) cur[i] = Math.min(cur[i - 1], prev[i - x] + cost[i - x]);
            long[] t = prev;
            prev = cur;
            cur = t;
        }
        return prev[n];
    }
}