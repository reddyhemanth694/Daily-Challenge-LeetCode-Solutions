/*
Brute Force

int minMoves(int* nums, int numsSize) {
    int moves = 0;
    while (1) {
        int mn = 0, mx = 0;
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] < nums[mn]) mn = i;
            if (nums[i] > nums[mx]) mx = i;
        }
        if (nums[mn] == nums[mx]) return moves;
        nums[mn]++;
        moves++;
    }
}
*/

/*
Better Approach

int cmp(const void* a, const void* b) {
    return *(const int*)a - *(const int*)b;
}

int minMoves(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int moves = 0;
    for (int i = 0; i < numsSize; i++) moves += nums[numsSize - 1] - nums[i];
    return moves;
}
*/

int minMoves(int* nums, int numsSize) {
    int mx = 0, sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > mx) mx = nums[i];
        sum += nums[i];
    }
    return mx * numsSize - sum;
}