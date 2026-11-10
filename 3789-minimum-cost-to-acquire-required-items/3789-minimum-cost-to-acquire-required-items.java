/*
Brute Force

class Solution {
    public long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long best = Long.MAX_VALUE;
        for (long k = 0; k <= Math.max(need1, need2); k++) {
            long cost = k * costBoth + Math.max(0, need1 - k) * cost1 + Math.max(0, need2 - k) * cost2;
            best = Math.min(best, cost);
        }
        return best;
    }
}
*/

/*
Better Approach

class Solution {
    long total(long k, int cost1, int cost2, int costBoth, int need1, int need2) {
        return k * costBoth + Math.max(0, need1 - k) * cost1 + Math.max(0, need2 - k) * cost2;
    }

    public long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long lo = 0, hi = Math.max(need1, need2);
        while (lo < hi) {
            long mid = (lo + hi) / 2;
            if (total(mid, cost1, cost2, costBoth, need1, need2) <= total(mid + 1, cost1, cost2, costBoth, need1, need2)) hi = mid;
            else lo = mid + 1;
        }
        return total(lo, cost1, cost2, costBoth, need1, need2);
    }
}
*/

class Solution {
    public long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long both = Math.min(need1, need2);
        return both * Math.min(costBoth, cost1 + cost2) + (need1 - both) * Math.min(cost1, costBoth) + (need2 - both) * Math.min(cost2, costBoth);
    }
}