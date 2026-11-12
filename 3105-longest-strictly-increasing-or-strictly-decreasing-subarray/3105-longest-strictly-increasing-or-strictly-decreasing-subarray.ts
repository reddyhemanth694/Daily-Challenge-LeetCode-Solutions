/*
Brute Force

function longestMonotonicSubarray(nums: number[]): number {
    const n = nums.length;
    let res = 1;
    for (let i = 0; i < n; i++) {
        let inc = 1, dec = 1;
        while (i + inc < n && nums[i + inc] > nums[i + inc - 1]) inc++;
        while (i + dec < n && nums[i + dec] < nums[i + dec - 1]) dec++;
        res = Math.max(res, inc, dec);
    }
    return res;
}
*/

/*
Better Approach

function longestMonotonicSubarray(nums: number[]): number {
    let res = 1, len = 1;
    for (let i = 1; i < nums.length; i++) {
        len = nums[i] > nums[i - 1] ? len + 1 : 1;
        res = Math.max(res, len);
    }
    len = 1;
    for (let i = 1; i < nums.length; i++) {
        len = nums[i] < nums[i - 1] ? len + 1 : 1;
        res = Math.max(res, len);
    }
    return res;
}
*/

function longestMonotonicSubarray(nums: number[]): number {
    let res = 1, inc = 1, dec = 1;
    for (let i = 1; i < nums.length; i++) {
        inc = nums[i] > nums[i - 1] ? inc + 1 : 1;
        dec = nums[i] < nums[i - 1] ? dec + 1 : 1;
        res = Math.max(res, inc, dec);
    }
    return res;
}