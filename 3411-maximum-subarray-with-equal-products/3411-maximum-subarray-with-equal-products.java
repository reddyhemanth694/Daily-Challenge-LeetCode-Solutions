class Solution {
    public int maxLength(int[] nums) {
        int n = nums.length, res = 0;
        for (int i = 0; i < n; i++) {
            long prod = 1, g = 0, l = 1;
            for (int j = i; j < n; j++) {
                prod *= nums[j];
                g = gcd(g, nums[j]);
                l = l / gcd(l, nums[j]) * nums[j];
                if (prod == l * g) res = Math.max(res, j - i + 1);
                if (prod > 25200) break;
            }
        }
        return res;
    }
    long gcd(long a, long b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}