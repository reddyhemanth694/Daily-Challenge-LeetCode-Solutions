/*
Brute Force

function numOfSubarrays(arr: number[]): number {
    const MOD = 1e9 + 7;
    const n = arr.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let sum = 0;
            for (let k = i; k <= j; k++) sum += arr[k];
            if (sum % 2 === 1) ans = (ans + 1) % MOD;
        }
    }
    return ans;
}
*/

/*
Better Approach

function numOfSubarrays(arr: number[]): number {
    const MOD = 1e9 + 7;
    const n = arr.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = i; j < n; j++) {
            sum += arr[j];
            if (sum % 2 === 1) ans = (ans + 1) % MOD;
        }
    }
    return ans;
}
*/

function numOfSubarrays(arr: number[]): number {
    const MOD = 1e9 + 7;
    let odd = 0, even = 1, sum = 0, ans = 0;
    for (const x of arr) {
        sum += x;
        if (sum % 2 === 1) {
            ans = (ans + even) % MOD;
            odd++;
        } else {
            ans = (ans + odd) % MOD;
            even++;
        }
    }
    return ans;
}