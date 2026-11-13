/*
Brute Force

int minimumSumSubarray(int* nums, int numsSize, int l, int r) {
    int ans = -1;
    for (int i = 0; i < numsSize; i++) {
        for (int len = l; len <= r && i + len <= numsSize; len++) {
            int sum = 0;
            for (int j = i; j < i + len; j++) sum += nums[j];
            if (sum > 0 && (ans == -1 || sum < ans)) ans = sum;
        }
    }
    return ans;
}
*/

/*
Better Approach

int minimumSumSubarray(int* nums, int numsSize, int l, int r) {
    int ans = -1;
    for (int i = 0; i < numsSize; i++) {
        int sum = 0;
        for (int j = i; j < numsSize && j - i + 1 <= r; j++) {
            sum += nums[j];
            if (j - i + 1 >= l && sum > 0 && (ans == -1 || sum < ans)) ans = sum;
        }
    }
    return ans;
}
*/

int lowerBound(int* a, int size, int x) {
    int lo = 0, hi = size;
    while (lo < hi) {
        int mid = (lo + hi) / 2;
        if (a[mid] < x) lo = mid + 1;
        else hi = mid;
    }
    return lo;
}

int minimumSumSubarray(int* nums, int numsSize, int l, int r) {
    int n = numsSize, ans = -1, size = 0;
    int* pre = (int*)malloc(sizeof(int) * (n + 1));
    int* win = (int*)malloc(sizeof(int) * (n + 1));
    pre[0] = 0;
    for (int i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
    for (int j = l; j <= n; j++) {
        int pos = lowerBound(win, size, pre[j - l]);
        memmove(win + pos + 1, win + pos, sizeof(int) * (size - pos));
        win[pos] = pre[j - l];
        size++;
        if (j - r - 1 >= 0) {
            pos = lowerBound(win, size, pre[j - r - 1]);
            memmove(win + pos, win + pos + 1, sizeof(int) * (size - pos - 1));
            size--;
        }
        int idx = lowerBound(win, size, pre[j]);
        if (idx > 0 && (ans == -1 || pre[j] - win[idx - 1] < ans)) ans = pre[j] - win[idx - 1];
    }
    free(pre);
    free(win);
    return ans;
}