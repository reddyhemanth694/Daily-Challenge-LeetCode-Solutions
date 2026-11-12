/*
Brute Force

long long countNonDecreasingSubarrays(int* nums, int numsSize, int k) {
    long long ans = 0;
    for (int l = 0; l < numsSize; l++) {
        long long cost = 0;
        int mx = 0;
        for (int r = l; r < numsSize; r++) {
            if (nums[r] > mx) mx = nums[r];
            cost += mx - nums[r];
            if (cost > k) break;
            ans++;
        }
    }
    return ans;
}
*/

/*
Better Approach

long long countNonDecreasingSubarrays(int* nums, int numsSize, int k) {
    int n = numsSize, lg = 1, w = numsSize + 1;
    while ((1 << lg) <= n) lg++;
    long long* pre = (long long*)calloc(w, sizeof(long long));
    for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
    int* up = (int*)malloc(sizeof(int) * lg * w);
    long long* sum = (long long*)malloc(sizeof(long long) * lg * w);
    int* st = (int*)malloc(sizeof(int) * n);
    int top = 0;
    up[n] = n;
    sum[n] = 0;
    for (int i = n - 1; i >= 0; i--) {
        while (top > 0 && nums[st[top - 1]] <= nums[i]) top--;
        int nx = top > 0 ? st[top - 1] : n;
        st[top++] = i;
        up[i] = nx;
        sum[i] = (long long)nums[i] * (nx - i) - (pre[nx] - pre[i]);
    }
    for (int j = 1; j < lg; j++)
        for (int i = 0; i <= n; i++) {
            int mid = up[(j - 1) * w + i];
            up[j * w + i] = up[(j - 1) * w + mid];
            sum[j * w + i] = sum[(j - 1) * w + i] + sum[(j - 1) * w + mid];
        }
    long long ans = 0;
    for (int l = 0; l < n; l++) {
        int cur = l;
        long long acc = 0;
        for (int j = lg - 1; j >= 0; j--) {
            if (cur < n && acc + sum[j * w + cur] <= k) {
                acc += sum[j * w + cur];
                cur = up[j * w + cur];
            }
        }
        if (cur == n) {
            ans += n - l;
            continue;
        }
        int lo = cur, hi = up[cur] - 1;
        while (lo < hi) {
            int mid = (lo + hi + 1) / 2;
            if (acc + (long long)nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) lo = mid;
            else hi = mid - 1;
        }
        ans += lo - l + 1;
    }
    free(pre);
    free(up);
    free(sum);
    free(st);
    return ans;
}
*/

long long countNonDecreasingSubarrays(int* nums, int numsSize, int k) {
    int n = numsSize, head = n, tail = n, r = n - 1;
    int* dq = (int*)malloc(sizeof(int) * n);
    long long ans = 0, cost = 0;
    for (int l = n - 1; l >= 0; l--) {
        while (head < tail && nums[dq[head]] <= nums[l]) {
            int i = dq[head++];
            int end = head < tail ? dq[head] : r + 1;
            cost += (long long)(nums[l] - nums[i]) * (end - i);
        }
        dq[--head] = l;
        while (cost > k) {
            cost -= nums[dq[tail - 1]] - nums[r];
            if (dq[tail - 1] == r) tail--;
            r--;
        }
        ans += r - l + 1;
    }
    free(dq);
    return ans;
}