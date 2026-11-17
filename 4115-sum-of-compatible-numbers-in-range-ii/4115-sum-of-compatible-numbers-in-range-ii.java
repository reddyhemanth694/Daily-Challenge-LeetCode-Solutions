class Solution {
    static final long MOD = 1_000_000_007L;
    static final int BITS = 52;
    long[] pow2 = new long[BITS + 2];
    int[] cntFree = new int[BITS + 1];
    long[] sFree = new long[BITS + 1];
    long n;

    public int sumOfGoodIntegers(long n, long k) {
        this.n = n;
        pow2[0] = 1;
        for (int i = 1; i < pow2.length; i++) pow2[i] = pow2[i - 1] * 2 % MOD;
        for (int i = 0; i < BITS; i++) {
            boolean free = ((n >> i) & 1L) == 0L;
            cntFree[i + 1] = cntFree[i] + (free ? 1 : 0);
            sFree[i + 1] = (sFree[i] + (free ? pow2[i] : 0)) % MOD;
        }
        long R = n + k;
        long L = Math.max(1L, n - k);
        return (int) ((f(R) - f(L - 1) + MOD) % MOD);
    }

    long f(long R) {
        if (R < 0) return 0;
        long res = 0, prefix = 0;
        for (int i = BITS - 1; i >= 0; i--) {
            if (((R >> i) & 1L) == 1L) {
                int c = cntFree[i];
                long add = prefix * pow2[c] % MOD;
                if (c > 0) add = (add + pow2[c - 1] * sFree[i]) % MOD;
                res = (res + add) % MOD;
                if (((n >> i) & 1L) != 0L) return res;
                prefix = (prefix + pow2[i]) % MOD;
            }
        }
        return (res + prefix) % MOD;
    }
}