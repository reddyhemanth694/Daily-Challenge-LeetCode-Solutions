/*
Brute Force

function minimumCost(cost1: number, cost2: number, costBoth: number, need1: number, need2: number): number {
    let best = Infinity;
    for (let k = 0; k <= Math.max(need1, need2); k++)
        best = Math.min(best, k * costBoth + Math.max(0, need1 - k) * cost1 + Math.max(0, need2 - k) * cost2);
    return best;
}
*/

/*
Better Approach

function minimumCost(cost1: number, cost2: number, costBoth: number, need1: number, need2: number): number {
    const total = (k: number): number => k * costBoth + Math.max(0, need1 - k) * cost1 + Math.max(0, need2 - k) * cost2;
    let lo = 0, hi = Math.max(need1, need2);
    while (lo < hi) {
        const mid = Math.floor((lo + hi) / 2);
        if (total(mid) <= total(mid + 1)) hi = mid;
        else lo = mid + 1;
    }
    return total(lo);
}
*/

function minimumCost(cost1: number, cost2: number, costBoth: number, need1: number, need2: number): number {
    const both = Math.min(need1, need2);
    return both * Math.min(costBoth, cost1 + cost2) + (need1 - both) * Math.min(cost1, costBoth) + (need2 - both) * Math.min(cost2, costBoth);
}