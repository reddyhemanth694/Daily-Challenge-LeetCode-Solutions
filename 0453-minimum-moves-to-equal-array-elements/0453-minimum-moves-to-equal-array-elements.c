/*
Brute Force

int minMoves(int* nums, int numsSize) {
    int moves = 0;
    while (1) {
        int mx = 0, same = 1;
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] != nums[0]) same = 0;
            if (nums[i] > nums[mx]) mx = i;
        }
        if (same) return moves;
        for (int i = 0; i < numsSize; i++)
            if (i != mx) nums[i]++;
        moves++;
    }
}
*/

/*
Better Approach

int cmp(const void* a, const void* b) {
    int x = *(const int*)a, y = *(const int*)b;
    return (x > y) - (x < y);
}

int minMoves(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long moves = 0;
    for (int i = 0; i < numsSize; i++) moves += (long long)nums[i] - nums[0];
    return (int)moves;
}
*/

int minMoves(int* nums, int numsSize) {
    int mn = nums[0];
    for (int i = 1; i < numsSize; i++)
        if (nums[i] < mn) mn = nums[i];
    long long moves = 0;
    for (int i = 0; i < numsSize; i++) moves += (long long)nums[i] - mn;
    return (int)moves;
}