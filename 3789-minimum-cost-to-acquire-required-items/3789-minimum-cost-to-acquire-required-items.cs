/*
Brute Force

public class Solution {
    public long MinimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long best = long.MaxValue;
        for (long k = 0; k <= Math.Max(need1, need2); k++) {
            long cost = k * costBoth + Math.Max(0, need1 - k) * cost1 + Math.Max(0, need2 - k) * cost2;
            best = Math.Min(best, cost);
        }
        return best;
    }
}
*/

/*
Better Approach

public class Solution {
    long Total(long k, int cost1, int cost2, int costBoth, int need1, int need2) {
        return k * costBoth + Math.Max(0, need1 - k) * cost1 + Math.Max(0, need2 - k) * cost2;
    }

    public long MinimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long lo = 0, hi = Math.Max(need1, need2);
        while (lo < hi) {
            long mid = (lo + hi) / 2;
            if (Total(mid, cost1, cost2, costBoth, need1, need2) <= Total(mid + 1, cost1, cost2, costBoth, need1, need2)) hi = mid;
            else lo = mid + 1;
        }
        return Total(lo, cost1, cost2, costBoth, need1, need2);
    }
}
*/

public class Solution {
    public long MinimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long both = Math.Min(need1, need2);
        return both * Math.Min(costBoth, cost1 + cost2) + (need1 - both) * Math.Min(cost1, costBoth) + (need2 - both) * Math.Min(cost2, costBoth);
    }
}