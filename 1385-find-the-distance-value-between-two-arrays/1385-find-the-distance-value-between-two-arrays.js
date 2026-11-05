/*
Brute Force

var findTheDistanceValue = function(arr1, arr2, d) {
    let ans = 0;
    for (const a of arr1)
        if (arr2.every(b => Math.abs(a - b) > d)) ans++;
    return ans;
};
*/

/*
Better Approach

var findTheDistanceValue = function(arr1, arr2, d) {
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
};
*/

var findTheDistanceValue = function(arr1, arr2, d) {
    const pre = new Int32Array(2202);
    for (const v of arr2) pre[v + 1101]++;
    for (let i = 1; i < 2202; i++) pre[i] += pre[i - 1];
    let ans = 0;
    for (const a of arr1)
        if (pre[a + d + 1101] === pre[a - d + 1100]) ans++;
    return ans;
};