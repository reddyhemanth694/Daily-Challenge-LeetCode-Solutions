/*
Brute Force

class Solution {
public:
    long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long long best = LLONG_MAX;
        for (long long k = 0; k <= max(need1, need2); k++) {
            long long cost = k * costBoth + max(0LL, need1 - k) * cost1 + max(0LL, need2 - k) * cost2;
            best = min(best, cost);
        }
        return best;
    }
};
*/

/*
Better Approach

class Solution {
public:
    long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        auto total = [&](long long k) {
            return k * costBoth + max(0LL, need1 - k) * cost1 + max(0LL, need2 - k) * cost2;
        };
        long long lo = 0, hi = max(need1, need2);
        while (lo < hi) {
            long long mid = (lo + hi) / 2;
            if (total(mid) <= total(mid + 1)) hi = mid;
            else lo = mid + 1;
        }
        return total(lo);
    }
};
*/

class Solution {
public:
    long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
        long long both = min(need1, need2);
        return both * min(costBoth, cost1 + cost2) + (need1 - both) * min(cost1, costBoth) + (need2 - both) * min(cost2, costBoth);
    }
};