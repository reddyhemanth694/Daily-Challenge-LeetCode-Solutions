/*
Brute Force

function minMoves2(nums: number[]): number {
    let best = Infinity;
    for (const x of nums) {
        let cost = 0;
        for (const a of nums) cost += Math.abs(a - x);
        best = Math.min(best, cost);
    }
    return best;
}
*/

/*
Better Approach

function minMoves2(nums: number[]): number {
    nums.sort((a, b) => a - b);
    const median = nums[nums.length >> 1];
    let moves = 0;
    for (const a of nums) moves += Math.abs(a - median);
    return moves;
}
*/

function minMoves2(nums: number[]): number {
    const swap = (i: number, j: number): void => {
        const t = nums[i];
        nums[i] = nums[j];
        nums[j] = t;
    };
    const k = nums.length >> 1;
    let lo = 0, hi = nums.length - 1, median = 0;
    while (true) {
        const pivot = nums[lo + Math.floor(Math.random() * (hi - lo + 1))];
        let lt = lo, i = lo, gt = hi;
        while (i <= gt) {
            if (nums[i] < pivot) swap(lt++, i++);
            else if (nums[i] > pivot) swap(i, gt--);
            else i++;
        }
        if (k < lt) hi = lt - 1;
        else if (k > gt) lo = gt + 1;
        else {
            median = pivot;
            break;
        }
    }
    let moves = 0;
    for (const a of nums) moves += Math.abs(a - median);
    return moves;
}