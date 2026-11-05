/*
Brute Force

class Solution {
    public int findTheDistanceValue(int[] arr1, int[] arr2, int d) {
        int ans = 0;
        for (int a : arr1) {
            boolean ok = true;
            for (int b : arr2) {
                if (Math.abs(a - b) <= d) {
                    ok = false;
                    break;
                }
            }
            if (ok) ans++;
        }
        return ans;
    }
}
*/

/*
Better Approach

class Solution {
    public int findTheDistanceValue(int[] arr1, int[] arr2, int d) {
        Arrays.sort(arr2);
        int ans = 0;
        for (int a : arr1) {
            int lo = 0, hi = arr2.length;
            while (lo < hi) {
                int mid = (lo + hi) / 2;
                if (arr2[mid] < a - d) lo = mid + 1;
                else hi = mid;
            }
            if (lo == arr2.length || arr2[lo] > a + d) ans++;
        }
        return ans;
    }
}
*/

class Solution {
    public int findTheDistanceValue(int[] arr1, int[] arr2, int d) {
        int[] pre = new int[2202];
        for (int v : arr2) pre[v + 1101]++;
        for (int i = 1; i < 2202; i++) pre[i] += pre[i - 1];
        int ans = 0;
        for (int a : arr1)
            if (pre[a + d + 1101] == pre[a - d + 1100]) ans++;
        return ans;
    }
}