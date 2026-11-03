/*
Brute Force

int cmp(const void* a, const void* b) {
    int x = *(const int*)a, y = *(const int*)b;
    return (x > y) - (x < y);
}

long long windowCost(int* nums, int i, int x) {
    int* w = (int*)malloc(sizeof(int) * x);
    for (int t = 0; t < x; t++) w[t] = nums[i + t];
    qsort(w, x, sizeof(int), cmp);
    long long med = w[x / 2], cost = 0;
    for (int t = 0; t < x; t++) cost += llabs(w[t] - med);
    free(w);
    return cost;
}

long long dfs(int* nums, int n, int x, int i, int j) {
    if (j == 0) return 0;
    if (n - i < (long long)j * x) return -1;
    long long skip = dfs(nums, n, x, i + 1, j);
    long long take = windowCost(nums, i, x) + dfs(nums, n, x, i + x, j - 1);
    return skip == -1 || take < skip ? take : skip;
}

long long minOperations(int* nums, int numsSize, int x, int k) {
    return dfs(nums, numsSize, x, 0, k);
}
*/

/*
Better Approach

int cmp(const void* a, const void* b) {
    int x = *(const int*)a, y = *(const int*)b;
    return (x > y) - (x < y);
}

long long minOperations(int* nums, int numsSize, int x, int k) {
    int n = numsSize;
    long long* cost = (long long*)calloc(n - x + 1, sizeof(long long));
    int* w = (int*)malloc(sizeof(int) * x);
    for (int i = 0; i + x <= n; i++) {
        for (int t = 0; t < x; t++) w[t] = nums[i + t];
        qsort(w, x, sizeof(int), cmp);
        long long med = w[x / 2];
        for (int t = 0; t < x; t++) cost[i] += llabs(w[t] - med);
    }
    const long long INF = 1LL << 60;
    long long* prev = (long long*)calloc(n + 1, sizeof(long long));
    long long* cur = (long long*)malloc(sizeof(long long) * (n + 1));
    for (int j = 1; j <= k; j++) {
        for (int i = 0; i <= n; i++) cur[i] = INF;
        for (int i = x; i <= n; i++) {
            long long take = prev[i - x] + cost[i - x];
            cur[i] = cur[i - 1] < take ? cur[i - 1] : take;
        }
        long long* t = prev;
        prev = cur;
        cur = t;
    }
    long long ans = prev[n];
    free(cost);
    free(w);
    free(prev);
    free(cur);
    return ans;
}
*/

int cmp(const void* a, const void* b) {
    int x = *(const int*)a, y = *(const int*)b;
    return (x > y) - (x < y);
}

long long minOperations(int* nums, int numsSize, int x, int k) {
    int n = numsSize;
    int* vals = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) vals[i] = nums[i];
    qsort(vals, n, sizeof(int), cmp);
    int m = 0;
    for (int i = 0; i < n; i++)
        if (i == 0 || vals[i] != vals[i - 1]) vals[m++] = vals[i];
    int top = 1;
    while (top * 2 <= m) top *= 2;
    int* idx = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        int lo = 0, hi = m;
        while (lo < hi) {
            int mid = (lo + hi) / 2;
            if (vals[mid] < nums[i]) lo = mid + 1;
            else hi = mid;
        }
        idx[i] = lo + 1;
    }
    long long* cnt = (long long*)calloc(m + 1, sizeof(long long));
    long long* sum = (long long*)calloc(m + 1, sizeof(long long));
    long long* cost = (long long*)calloc(n - x + 1, sizeof(long long));
    long long total = 0;
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
            long long need = half, lowCnt = 0, lowSum = 0;
            for (int step = top; step > 0; step >>= 1) {
                if (pos + step <= m && cnt[pos + step] < need) {
                    pos += step;
                    need -= cnt[pos];
                    lowCnt += cnt[pos];
                    lowSum += sum[pos];
                }
            }
            long long med = vals[pos];
            cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
        }
    }
    const long long INF = 1LL << 60;
    long long* prev = (long long*)calloc(n + 1, sizeof(long long));
    long long* cur = (long long*)malloc(sizeof(long long) * (n + 1));
    for (int j = 1; j <= k; j++) {
        for (int i = 0; i <= n; i++) cur[i] = INF;
        for (int i = x; i <= n; i++) {
            long long take = prev[i - x] + cost[i - x];
            cur[i] = cur[i - 1] < take ? cur[i - 1] : take;
        }
        long long* t = prev;
        prev = cur;
        cur = t;
    }
    long long ans = prev[n];
    free(vals);
    free(idx);
    free(cnt);
    free(sum);
    free(cost);
    free(prev);
    free(cur);
    return ans;
}