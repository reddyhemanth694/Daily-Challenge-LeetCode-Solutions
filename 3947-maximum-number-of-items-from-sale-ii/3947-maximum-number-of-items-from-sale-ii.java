class Solution {
    public int maximumSaleItems(int[][] items, int budget) {
        int n = items.length;
        int[] cnt = new int[n + 1];
        long minPrice = Long.MAX_VALUE;
        for (int[] it : items) {
            cnt[it[0]]++;
            minPrice = Math.min(minPrice, it[1]);
        }
        long[] deg = new long[n + 1];
        for (int f = 1; f <= n; f++) {
            if (cnt[f] == 0) continue;
            long s = 0;
            for (int m = f; m <= n; m += f) s += cnt[m];
            deg[f] = s - 1;
        }
        Integer[] idx = new Integer[n];
        for (int i = 0; i < n; i++) idx[i] = i;
        Arrays.sort(idx, (a, b) -> Integer.compare(items[a][1], items[b][1]));
        long rem = budget, total = 0;
        for (int t = 0; t < n; t++) {
            int[] it = items[idx[t]];
            long q = it[1];
            if (q > 2 * minPrice) break;
            long c = Math.min(deg[it[0]], rem / q);
            total += 2 * c;
            rem -= c * q;
        }
        total += rem / minPrice;
        return (int) total;
    }
}