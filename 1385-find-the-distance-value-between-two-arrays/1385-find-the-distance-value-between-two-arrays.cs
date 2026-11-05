/*
Brute Force

public class Solution {
    public int FindTheDistanceValue(int[] arr1, int[] arr2, int d) {
        int ans = 0;
        foreach (int a in arr1) {
            bool ok = true;
            foreach (int b in arr2) {
                if (Math.Abs(a - b) <= d) {
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

public class Solution {
    public int FindTheDistanceValue(int[] arr1, int[] arr2, int d) {
        Array.Sort(arr2);
        int ans = 0;
        foreach (int a in arr1) {
            int lo = 0, hi = arr2.Length;
            while (lo < hi) {
                int mid = (lo + hi) / 2;
                if (arr2[mid] < a - d) lo = mid + 1;
                else hi = mid;
            }
            if (lo == arr2.Length || arr2[lo] > a + d) ans++;
        }
        return ans;
    }
}
*/

public class Solution {
    public int FindTheDistanceValue(int[] arr1, int[] arr2, int d) {
        int[] pre = new int[2202];
        foreach (int v in arr2) pre[v + 1101]++;
        for (int i = 1; i < 2202; i++) pre[i] += pre[i - 1];
        int ans = 0;
        foreach (int a in arr1)
            if (pre[a + d + 1101] == pre[a - d + 1100]) ans++;
        return ans;
    }
}