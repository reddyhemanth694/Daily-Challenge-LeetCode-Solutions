/*
Brute Force

int* countServers(int n, int** logs, int logsSize, int* logsColSize, int x, int* queries, int queriesSize, int* returnSize) {
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    bool* seen = (bool*)malloc(sizeof(bool) * (n + 1));
    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i], cnt = 0;
        memset(seen, 0, sizeof(bool) * (n + 1));
        for (int j = 0; j < logsSize; j++) {
            int s = logs[j][0], t = logs[j][1];
            if (t >= q - x && t <= q && !seen[s]) {
                seen[s] = true;
                cnt++;
            }
        }
        ans[i] = n - cnt;
    }
    free(seen);
    *returnSize = queriesSize;
    return ans;
}
*/

/*
Better Approach

int cmpLog(const void* a, const void* b) {
    return (*(int* const*)a)[1] - (*(int* const*)b)[1];
}

int* countServers(int n, int** logs, int logsSize, int* logsColSize, int x, int* queries, int queriesSize, int* returnSize) {
    qsort(logs, logsSize, sizeof(int*), cmpLog);
    int* stamp = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) stamp[i] = -1;
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    for (int i = 0; i < queriesSize; i++) {
        int lo = 0, hi = logsSize;
        while (lo < hi) {
            int mid = (lo + hi) / 2;
            if (logs[mid][1] < queries[i] - x) lo = mid + 1;
            else hi = mid;
        }
        int cnt = 0;
        for (int j = lo; j < logsSize && logs[j][1] <= queries[i]; j++) {
            if (stamp[logs[j][0]] != i) {
                stamp[logs[j][0]] = i;
                cnt++;
            }
        }
        ans[i] = n - cnt;
    }
    free(stamp);
    *returnSize = queriesSize;
    return ans;
}
*/

int cmpLog(const void* a, const void* b) {
    return (*(int* const*)a)[1] - (*(int* const*)b)[1];
}

int cmpKey(const void* a, const void* b) {
    long long u = *(const long long*)a, v = *(const long long*)b;
    return (u > v) - (u < v);
}

int* countServers(int n, int** logs, int logsSize, int* logsColSize, int x, int* queries, int queriesSize, int* returnSize) {
    qsort(logs, logsSize, sizeof(int*), cmpLog);
    long long* order = (long long*)malloc(sizeof(long long) * queriesSize);
    for (int i = 0; i < queriesSize; i++) order[i] = (long long)queries[i] * 131072 + i;
    qsort(order, queriesSize, sizeof(long long), cmpKey);
    int* cnt = (int*)calloc(n + 1, sizeof(int));
    int* ans = (int*)malloc(sizeof(int) * queriesSize);
    int l = 0, r = 0, distinct = 0;
    for (int k = 0; k < queriesSize; k++) {
        int i = order[k] % 131072, q = queries[i];
        while (r < logsSize && logs[r][1] <= q)
            if (cnt[logs[r++][0]]++ == 0) distinct++;
        while (l < r && logs[l][1] < q - x)
            if (--cnt[logs[l++][0]] == 0) distinct--;
        ans[i] = n - distinct;
    }
    free(order);
    free(cnt);
    *returnSize = queriesSize;
    return ans;
}