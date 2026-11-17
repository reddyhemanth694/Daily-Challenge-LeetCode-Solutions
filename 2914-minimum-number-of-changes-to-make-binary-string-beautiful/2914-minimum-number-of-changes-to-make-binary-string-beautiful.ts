/*
Brute Force

function minChanges(s: string): number {
    const n = s.length;
    const solve = (i: number): number => {
        if (i === n) return 0;
        let best = n, ones = 0;
        for (let j = i; j < n; j++) {
            if (s[j] === '1') ones++;
            const len = j - i + 1;
            if (len % 2 === 0) best = Math.min(best, Math.min(ones, len - ones) + solve(j + 1));
        }
        return best;
    };
    return solve(0);
}
*/

/*
Better Approach

function minChanges(s: string): number {
    const n = s.length;
    const dp: number[] = new Array(n + 1).fill(n);
    dp[0] = 0;
    for (let i = 0; i < n; i += 2) {
        let ones = 0;
        for (let j = i; j < n; j++) {
            if (s[j] === '1') ones++;
            const len = j - i + 1;
            if (len % 2 === 0) dp[j + 1] = Math.min(dp[j + 1], dp[i] + Math.min(ones, len - ones));
        }
    }
    return dp[n];
}
*/

function minChanges(s: string): number {
    let ans = 0;
    for (let i = 0; i < s.length; i += 2) {
        if (s[i] !== s[i + 1]) ans++;
    }
    return ans;
}