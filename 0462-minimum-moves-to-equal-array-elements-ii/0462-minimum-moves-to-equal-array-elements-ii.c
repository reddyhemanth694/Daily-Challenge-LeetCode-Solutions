/*
Brute Force

int minMoves2(int* nums, int numsSize) {
    long long best = -1;
    for (int i = 0; i < numsSize; i++) {
        long long cost = 0;
        for (int j = 0; j < numsSize; j++) cost += llabs((long long)nums[j] - nums[i]);
        if (best == -1 || cost < best) best = cost;
    }
    return (int)best;
}
*/

/*
Better Approach

int cmp(const void* a, const void* b) {
    int x = *(const int*)a, y = *(const int*)b;
    return (x > y) - (x < y);
}

int minMoves2(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long median = nums[numsSize / 2], moves = 0;
    for (int i = 0; i < numsSize; i++) moves += llabs(nums[i] - median);
    return (int)moves;
}
*/

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

int minMoves2(int* nums, int numsSize) {
    int k = numsSize / 2, lo = 0, hi = numsSize - 1;
    long long median = 0;
    while (1) {
        int pivot = nums[lo + rand() % (hi - lo + 1)];
        int lt = lo, i = lo, gt = hi;
        while (i <= gt) {
            if (nums[i] < pivot) swap(&nums[lt++], &nums[i++]);
            else if (nums[i] > pivot) swap(&nums[i], &nums[gt--]);
            else i++;
        }
        if (k < lt) hi = lt - 1;
        else if (k > gt) lo = gt + 1;
        else {
            median = pivot;
            break;
        }
    }
    long long moves = 0;
    for (int i = 0; i < numsSize; i++) moves += llabs(nums[i] - median);
    return (int)moves;
}