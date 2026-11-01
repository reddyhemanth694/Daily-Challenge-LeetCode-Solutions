/*
Brute Force

var minMoves = function(nums) {
    let moves = 0;
    while (true) {
        let mx = 0, same = true;
        for (let i = 1; i < nums.length; i++) {
            if (nums[i] !== nums[0]) same = false;
            if (nums[i] > nums[mx]) mx = i;
        }
        if (same) return moves;
        for (let i = 0; i < nums.length; i++)
            if (i !== mx) nums[i]++;
        moves++;
    }
};
*/

/*
Better Approach

var minMoves = function(nums) {
    nums.sort((a, b) => a - b);
    let moves = 0;
    for (const x of nums) moves += x - nums[0];
    return moves;
};
*/

var minMoves = function(nums) {
    let mn = nums[0];
    for (const x of nums) mn = Math.min(mn, x);
    let moves = 0;
    for (const x of nums) moves += x - mn;
    return moves;
};