/*
Brute Force

int numOfSubarrays(int* arr, int arrSize) {
    const int MOD = 1000000007;
    int ans = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = i; j < arrSize; j++) {
            int sum = 0;
            for (int k = i; k <= j; k++) sum += arr[k];
            if (sum % 2 == 1) ans = (ans + 1) % MOD;
        }
    }
    return ans;
}
*/

/*
Better Approach

int numOfSubarrays(int* arr, int arrSize) {
    const int MOD = 1000000007;
    int ans = 0;
    for (int i = 0; i < arrSize; i++) {
        int sum = 0;
        for (int j = i; j < arrSize; j++) {
            sum += arr[j];
            if (sum % 2 == 1) ans = (ans + 1) % MOD;
        }
    }
    return ans;
}
*/

int numOfSubarrays(int* arr, int arrSize) {
    const int MOD = 1000000007;
    int odd = 0, even = 1, sum = 0, ans = 0;
    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
        if (sum % 2 == 1) {
            ans = (ans + even) % MOD;
            odd++;
        } else {
            ans = (ans + odd) % MOD;
            even++;
        }
    }
    return ans;
}