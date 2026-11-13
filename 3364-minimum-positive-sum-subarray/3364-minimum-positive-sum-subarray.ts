/*
Brute Force

function minimumSumSubarray(nums: number[], l: number, r: number): number {
    const n = nums.length;
    let ans = Infinity;
    for (let i = 0; i < n; i++) {
        for (let len = l; len <= r && i + len <= n; len++) {
            let sum = 0;
            for (let j = i; j < i + len; j++) sum += nums[j];
            if (sum > 0) ans = Math.min(ans, sum);
        }
    }
    return ans === Infinity ? -1 : ans;
}
*/

/*
Better Approach

function minimumSumSubarray(nums: number[], l: number, r: number): number {
    const n = nums.length;
    let ans = Infinity;
    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = i; j < n && j - i + 1 <= r; j++) {
            sum += nums[j];
            if (j - i + 1 >= l && sum > 0) ans = Math.min(ans, sum);
        }
    }
    return ans === Infinity ? -1 : ans;
}
*/

function minimumSumSubarray(nums: number[], l: number, r: number): number {
    const n = nums.length;
    const pre: number[] = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
    const lowerBound = (arr: number[], x: number): number => {
        let lo = 0, hi = arr.length;
        while (lo < hi) {
            const mid = (lo + hi) >> 1;
            if (arr[mid] < x) lo = mid + 1;
            else hi = mid;
        }
        return lo;
    };
    const win: number[] = [];
    let ans = Infinity;
    for (let j = l; j <= n; j++) {
        win.splice(lowerBound(win, pre[j - l]), 0, pre[j - l]);
        if (j - r - 1 >= 0) win.splice(lowerBound(win, pre[j - r - 1]), 1);
        const idx = lowerBound(win, pre[j]);
        if (idx > 0) ans = Math.min(ans, pre[j] - win[idx - 1]);
    }
    return ans === Infinity ? -1 : ans;
}