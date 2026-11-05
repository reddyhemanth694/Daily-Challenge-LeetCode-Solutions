/*
Brute Force

function findTheDistanceValue(arr1: number[], arr2: number[], d: number): number {
    let ans = 0;
    for (const a of arr1)
        if (arr2.every(b => Math.abs(a - b) > d)) ans++;
    return ans;
}
*/

/*
Better Approach

function findTheDistanceValue(arr1: number[], arr2: number[], d: number): number {
    arr2.sort((a, b) => a - b);
    let ans = 0;
    for (const a of arr1) {
        let lo = 0, hi = arr2.length;
        while (lo < hi) {
            const mid = (lo + hi) >> 1;
            if (arr2[mid] < a - d) lo = mid + 1;
            else hi = mid;
        }
        if (lo === arr2.length || arr2[lo] > a + d) ans++;
    }
    return ans;
}
*/

function findTheDistanceValue(arr1: number[], arr2: number[], d: number): number {
    const pre = new Int32Array(2202);
    for (const v of arr2) pre[v + 1101]++;
    for (let i = 1; i < 2202; i++) pre[i] += pre[i - 1];
    let ans = 0;
    for (const a of arr1)
        if (pre[a + d + 1101] === pre[a - d + 1100]) ans++;
    return ans;
}