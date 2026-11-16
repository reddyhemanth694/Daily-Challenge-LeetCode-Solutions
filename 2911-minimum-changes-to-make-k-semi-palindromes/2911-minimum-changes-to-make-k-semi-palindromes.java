/*
Brute Force

class Solution {
    private int cost(char[] b, int l, int r) {
        int len = r - l + 1;
        int best = 1000000000;
        for (int d = 1; d < len; d++) {
            if (len % d != 0) {
                continue;
            }
            int m = len / d;
            int c = 0;
            for (int g = 0; g < d; g++) {
                for (int t = 0; t < m / 2; t++) {
                    if (b[l + g + t * d] != b[l + g + (m - 1 - t) * d]) {
                        c++;
                    }
                }
            }
            best = Math.min(best, c);
        }
        return best;
    }

    private int rec(char[] b, int i, int parts) {
        int n = b.length;
        if (parts == 1) {
            return cost(b, i, n - 1);
        }
        int best = 1000000000;
        for (int j = i + 1; j <= n - 1 - 2 * (parts - 1); j++) {
            best = Math.min(best, cost(b, i, j) + rec(b, j + 1, parts - 1));
        }
        return best;
    }

    public int minimumChanges(String s, int k) {
        return rec(s.toCharArray(), 0, k);
    }
}
*/

/*
Better Approach

class Solution {
    private int solve(int i, int parts, int n, int[][] cost, int[][] memo) {
        if (parts == 1) {
            return cost[i][n - 1];
        }
        if (memo[i][parts] != -1) {
            return memo[i][parts];
        }
        int best = 1000000000;
        for (int j = i + 1; j <= n - 1 - 2 * (parts - 1); j++) {
            best = Math.min(best, cost[i][j] + solve(j + 1, parts - 1, n, cost, memo));
        }
        return memo[i][parts] = best;
    }

    public int minimumChanges(String s, int k) {
        char[] b = s.toCharArray();
        int n = b.length;
        int INF = 1000000000;
        int[][] cost = new int[n][n];
        for (int[] row : cost) {
            java.util.Arrays.fill(row, INF);
        }
        for (int l = 0; l < n; l++) {
            for (int r = l + 1; r < n; r++) {
                int len = r - l + 1;
                int best = INF;
                for (int d = 1; d < len; d++) {
                    if (len % d != 0) {
                        continue;
                    }
                    int m = len / d;
                    int c = 0;
                    for (int g = 0; g < d; g++) {
                        for (int t = 0; t < m / 2; t++) {
                            if (b[l + g + t * d] != b[l + g + (m - 1 - t) * d]) {
                                c++;
                            }
                        }
                    }
                    best = Math.min(best, c);
                }
                cost[l][r] = best;
            }
        }
        int[][] memo = new int[n][k + 1];
        for (int[] row : memo) {
            java.util.Arrays.fill(row, -1);
        }
        return solve(0, k, n, cost, memo);
    }
}
*/

class Solution {
    public int minimumChanges(String s, int k) {
        char[] b = s.toCharArray();
        int n = b.length;
        int INF = 1000000000;
        int[][] cost = new int[n][n];
        for (int[] row : cost) {
            java.util.Arrays.fill(row, INF);
        }
        for (int l = 0; l < n; l++) {
            for (int r = l + 1; r < n; r++) {
                int len = r - l + 1;
                int best = INF;
                for (int d = 1; d < len; d++) {
                    if (len % d != 0) {
                        continue;
                    }
                    int m = len / d;
                    int c = 0;
                    for (int g = 0; g < d; g++) {
                        for (int t = 0; t < m / 2; t++) {
                            if (b[l + g + t * d] != b[l + g + (m - 1 - t) * d]) {
                                c++;
                            }
                        }
                    }
                    best = Math.min(best, c);
                }
                cost[l][r] = best;
            }
        }
        int[] prev = new int[n + 1];
        java.util.Arrays.fill(prev, INF);
        prev[0] = 0;
        for (int p = 1; p <= k; p++) {
            int[] cur = new int[n + 1];
            java.util.Arrays.fill(cur, INF);
            for (int j = 2 * p; j <= n; j++) {
                for (int i = 2 * (p - 1); i <= j - 2; i++) {
                    if (prev[i] < INF) {
                        cur[j] = Math.min(cur[j], prev[i] + cost[i][j - 1]);
                    }
                }
            }
            prev = cur;
        }
        return prev[n];
    }
}