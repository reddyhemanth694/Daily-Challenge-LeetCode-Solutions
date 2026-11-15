/*
Brute Force

public class Solution {
    public int NumOfSubarrays(int[] arr) {
        const int MOD = 1000000007;
        int n = arr.Length, ans = 0;
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

public class Solution {
    public int NumOfSubarrays(int[] arr) {
        const int MOD = 1000000007;
        int n = arr.Length, ans = 0;
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

public class Solution {
    public int NumOfSubarrays(int[] arr) {
        const int MOD = 1000000007;
        int odd = 0, even = 1, sum = 0, ans = 0;
        foreach (int x in arr) {
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