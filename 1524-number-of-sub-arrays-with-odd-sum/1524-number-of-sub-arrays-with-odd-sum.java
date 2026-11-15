/*
Brute Force

class Solution {
    public int numOfSubarrays(int[] arr) {
        final int MOD = 1_000_000_007;
        int n = arr.length, ans = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int sum = 0;
                for (int k = i; k <= j; k++) sum += arr[k];
                if (sum % 2 == 1) ans = (ans + 1) % MOD;
            }
        }
        return ans;
    }
}
*/

/*
Better Approach

class Solution {
    public int numOfSubarrays(int[] arr) {
        final int MOD = 1_000_000_007;
        int n = arr.length, ans = 0;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                sum += arr[j];
                if (sum % 2 == 1) ans = (ans + 1) % MOD;
            }
        }
        return ans;
    }
}
*/

class Solution {
    public int numOfSubarrays(int[] arr) {
        final int MOD = 1_000_000_007;
        int odd = 0, even = 1, sum = 0, ans = 0;
        for (int x : arr) {
            sum += x;
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
}