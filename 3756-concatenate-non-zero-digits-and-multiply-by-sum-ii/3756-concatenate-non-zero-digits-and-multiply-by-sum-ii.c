/*
Brute Force

int* sumAndMultiply(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    const long long MOD = 1000000007;
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int k = 0; k < queriesSize; k++) {
        long long x = 0, sum = 0;
        for (int i = queries[k][0]; i <= queries[k][1]; i++) {
            int d = s[i] - '0';
            if (d != 0) {
                x = (x * 10 + d) % MOD;
                sum += d;
            }
        }
        ans[k] = (int)(x * sum % MOD);
    }
    return ans;
}
*/

/*
Better Approach

long long power(long long b, int e) {
    long long r = 1;
    while (e > 0) {
        if (e & 1) r = r * b % 1000000007;
        b = b * b % 1000000007;
        e >>= 1;
    }
    return r;
}

int* sumAndMultiply(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    const long long MOD = 1000000007;
    int m = strlen(s);
    long long* pre = (long long*)calloc(m + 1, sizeof(long long));
    int* cnt = (int*)calloc(m + 1, sizeof(int));
    int* sum = (int*)calloc(m + 1, sizeof(int));
    for (int i = 0; i < m; i++) {
        int d = s[i] - '0';
        pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
        cnt[i + 1] = cnt[i] + (d != 0);
        sum[i + 1] = sum[i] + d;
    }
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int k = 0; k < queriesSize; k++) {
        int l = queries[k][0], r = queries[k][1] + 1;
        long long x = ((pre[r] - pre[l] * power(10, cnt[r] - cnt[l])) % MOD + MOD) % MOD;
        ans[k] = (int)(x * (sum[r] - sum[l]) % MOD);
    }
    free(pre);
    free(cnt);
    free(sum);
    return ans;
}
*/

int* sumAndMultiply(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    const long long MOD = 1000000007;
    int m = strlen(s);
    long long* pre = (long long*)calloc(m + 1, sizeof(long long));
    long long* pw = (long long*)calloc(m + 1, sizeof(long long));
    int* cnt = (int*)calloc(m + 1, sizeof(int));
    int* sum = (int*)calloc(m + 1, sizeof(int));
    pw[0] = 1;
    for (int i = 0; i < m; i++) {
        int d = s[i] - '0';
        pw[i + 1] = pw[i] * 10 % MOD;
        pre[i + 1] = d != 0 ? (pre[i] * 10 + d) % MOD : pre[i];
        cnt[i + 1] = cnt[i] + (d != 0);
        sum[i + 1] = sum[i] + d;
    }
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    for (int k = 0; k < queriesSize; k++) {
        int l = queries[k][0], r = queries[k][1] + 1;
        long long x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD + MOD) % MOD;
        ans[k] = (int)(x * (sum[r] - sum[l]) % MOD);
    }
    free(pre);
    free(pw);
    free(cnt);
    free(sum);
    return ans;
}