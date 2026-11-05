/*
Brute Force

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int d) {
    int ans = 0;
    for (int i = 0; i < arr1Size; i++) {
        bool ok = true;
        for (int j = 0; j < arr2Size; j++) {
            if (abs(arr1[i] - arr2[j]) <= d) {
                ok = false;
                break;
            }
        }
        if (ok) ans++;
    }
    return ans;
}
*/

/*
Better Approach

int cmp(const void* a, const void* b) {
    return *(const int*)a - *(const int*)b;
}

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int d) {
    qsort(arr2, arr2Size, sizeof(int), cmp);
    int ans = 0;
    for (int i = 0; i < arr1Size; i++) {
        int lo = 0, hi = arr2Size;
        while (lo < hi) {
            int mid = (lo + hi) / 2;
            if (arr2[mid] < arr1[i] - d) lo = mid + 1;
            else hi = mid;
        }
        if (lo == arr2Size || arr2[lo] > arr1[i] + d) ans++;
    }
    return ans;
}
*/

int findTheDistanceValue(int* arr1, int arr1Size, int* arr2, int arr2Size, int d) {
    int pre[2202] = {0};
    for (int j = 0; j < arr2Size; j++) pre[arr2[j] + 1101]++;
    for (int i = 1; i < 2202; i++) pre[i] += pre[i - 1];
    int ans = 0;
    for (int i = 0; i < arr1Size; i++)
        if (pre[arr1[i] + d + 1101] == pre[arr1[i] - d + 1100]) ans++;
    return ans;
}