/*
Brute Force

int solve(char* s, int n, int i) {
    if (i == n) return 0;
    int best = n, ones = 0;
    for (int j = i; j < n; j++) {
        if (s[j] == '1') ones++;
        int len = j - i + 1;
        if (len % 2 == 0) {
            int zeros = len - ones;
            int cost = (ones < zeros ? ones : zeros) + solve(s, n, j + 1);
            if (cost < best) best = cost;
        }
    }
    return best;
}

int minChanges(char* s) {
    return solve(s, strlen(s), 0);
}
*/

/*
Better Approach

int minChanges(char* s) {
    int n = strlen(s);
    int* dp = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) dp[i] = n;
    dp[0] = 0;
    for (int i = 0; i < n; i += 2) {
        int ones = 0;
        for (int j = i; j < n; j++) {
            if (s[j] == '1') ones++;
            int len = j - i + 1;
            if (len % 2 == 0) {
                int zeros = len - ones;
                int cost = dp[i] + (ones < zeros ? ones : zeros);
                if (cost < dp[j + 1]) dp[j + 1] = cost;
            }
        }
    }
    int ans = dp[n];
    free(dp);
    return ans;
}
*/

int minChanges(char* s) {
    int ans = 0;
    for (int i = 0; s[i]; i += 2) {
        if (s[i] != s[i + 1]) ans++;
    }
    return ans;
}