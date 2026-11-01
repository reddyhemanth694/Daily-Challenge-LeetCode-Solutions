/*
Brute Force

function sumAndMultiply(s: string, queries: number[][]): number[] {
    const MOD = 1_000_000_007;
    return queries.map(([l, r]) => {
        let x = 0, sum = 0;
        for (let i = l; i <= r; i++) {
            const d = s.charCodeAt(i) - 48;
            if (d !== 0) {
                x = (x * 10 + d) % MOD;
                sum += d;
            }
        }
        return x * sum % MOD;
    });
}
*/

/*
Better Approach

function sumAndMultiply(s: string, queries: number[][]): number[] {
    const MOD = 1_000_000_007n;
    const power = (b: bigint, e: number): bigint => {
        let r = 1n;
        while (e > 0) {
            if (e & 1) r = r * b % MOD;
            b = b * b % MOD;
            e >>= 1;
        }
        return r;
    };
    const m = s.length;
    const pre: bigint[] = new Array(m + 1).fill(0n);
    const cnt = new Int32Array(m + 1), sum = new Int32Array(m + 1);
    for (let i = 0; i < m; i++) {
        const d = s.charCodeAt(i) - 48;
        pre[i + 1] = d !== 0 ? (pre[i] * 10n + BigInt(d)) % MOD : pre[i];
        cnt[i + 1] = cnt[i] + (d !== 0 ? 1 : 0);
        sum[i + 1] = sum[i] + d;
    }
    return queries.map(([l, r]) => {
        r++;
        const x = ((pre[r] - pre[l] * power(10n, cnt[r] - cnt[l])) % MOD + MOD) % MOD;
        return Number(x * BigInt(sum[r] - sum[l]) % MOD);
    });
}
*/

function sumAndMultiply(s: string, queries: number[][]): number[] {
    const MOD = 1_000_000_007n;
    const m = s.length;
    const pre: bigint[] = new Array(m + 1).fill(0n), pw: bigint[] = new Array(m + 1).fill(1n);
    const cnt = new Int32Array(m + 1), sum = new Int32Array(m + 1);
    for (let i = 0; i < m; i++) {
        const d = s.charCodeAt(i) - 48;
        pw[i + 1] = pw[i] * 10n % MOD;
        pre[i + 1] = d !== 0 ? (pre[i] * 10n + BigInt(d)) % MOD : pre[i];
        cnt[i + 1] = cnt[i] + (d !== 0 ? 1 : 0);
        sum[i + 1] = sum[i] + d;
    }
    return queries.map(([l, r]) => {
        r++;
        const x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % MOD + MOD) % MOD;
        return Number(x * BigInt(sum[r] - sum[l]) % MOD);
    });
}