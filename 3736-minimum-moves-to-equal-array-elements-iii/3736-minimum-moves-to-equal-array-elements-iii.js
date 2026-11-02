/*
Brute Force

var minMoves = function(nums) {
    let moves = 0;
    while (true) {
        let mn = 0, mx = 0;
        for (let i = 1; i < nums.length; i++) {
            if (nums[i] < nums[mn]) mn = i;
            if (nums[i] > nums[mx]) mx = i;
        }
        if (nums[mn] === nums[mx]) return moves;
        nums[mn]++;
        moves++;
    }
};
*/

/*
Better Approach

var minMoves = function(nums) {
    nums.sort((a, b) => a - b);
    let moves = 0;
    for (const x of nums) moves += nums[nums.length - 1] - x;
    return moves;
};
*/

var minMoves = function(nums) {
    let mx = 0, sum = 0;
    for (const x of nums) {
        mx = Math.max(mx, x);
        sum += x;
    }
    return mx * nums.length - sum;
};