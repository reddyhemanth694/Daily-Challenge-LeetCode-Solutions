/*
Brute Force

class Solution {
    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int q = queries[i];
            boolean[] seen = new boolean[n + 1];
            int cnt = 0;
            for (int[] lg : logs) {
                if (lg[1] >= q - x && lg[1] <= q && !seen[lg[0]]) {
                    seen[lg[0]] = true;
                    cnt++;
                }
            }
            ans[i] = n - cnt;
        }
        return ans;
    }
}
*/

/*
Better Approach

class Solution {
    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        Arrays.sort(logs, (a, b) -> a[1] - b[1]);
        int m = logs.length, k = queries.length;
        int[] stamp = new int[n + 1], ans = new int[k];
        Arrays.fill(stamp, -1);
        for (int i = 0; i < k; i++) {
            int lo = 0, hi = m;
            while (lo < hi) {
                int mid = (lo + hi) / 2;
                if (logs[mid][1] < queries[i] - x) lo = mid + 1;
                else hi = mid;
            }
            int cnt = 0;
            for (int j = lo; j < m && logs[j][1] <= queries[i]; j++) {
                if (stamp[logs[j][0]] != i) {
                    stamp[logs[j][0]] = i;
                    cnt++;
                }
            }
            ans[i] = n - cnt;
        }
        return ans;
    }
}
*/

class Solution {
    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        Arrays.sort(logs, (a, b) -> a[1] - b[1]);
        int m = logs.length, k = queries.length;
        Integer[] idx = new Integer[k];
        for (int i = 0; i < k; i++) idx[i] = i;
        Arrays.sort(idx, (a, b) -> queries[a] - queries[b]);
        int[] cnt = new int[n + 1], ans = new int[k];
        int l = 0, r = 0, distinct = 0;
        for (int i : idx) {
            int q = queries[i];
            while (r < m && logs[r][1] <= q)
                if (cnt[logs[r++][0]]++ == 0) distinct++;
            while (l < r && logs[l][1] < q - x)
                if (--cnt[logs[l++][0]] == 0) distinct--;
            ans[i] = n - distinct;
        }
        return ans;
    }
}