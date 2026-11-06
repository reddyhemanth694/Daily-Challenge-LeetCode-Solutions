/*
Brute Force

public class Solution {
    public int[] CountServers(int n, int[][] logs, int x, int[] queries) {
        int[] ans = new int[queries.Length];
        for (int i = 0; i < queries.Length; i++) {
            int q = queries[i];
            bool[] seen = new bool[n + 1];
            int cnt = 0;
            foreach (int[] lg in logs) {
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

public class Solution {
    public int[] CountServers(int n, int[][] logs, int x, int[] queries) {
        Array.Sort(logs, (a, b) => a[1].CompareTo(b[1]));
        int m = logs.Length, k = queries.Length;
        int[] stamp = new int[n + 1], ans = new int[k];
        Array.Fill(stamp, -1);
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

public class Solution {
    public int[] CountServers(int n, int[][] logs, int x, int[] queries) {
        Array.Sort(logs, (a, b) => a[1].CompareTo(b[1]));
        int m = logs.Length, k = queries.Length;
        int[] keys = (int[])queries.Clone(), idx = new int[k], cnt = new int[n + 1], ans = new int[k];
        for (int i = 0; i < k; i++) idx[i] = i;
        Array.Sort(keys, idx);
        int l = 0, r = 0, distinct = 0;
        foreach (int i in idx) {
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