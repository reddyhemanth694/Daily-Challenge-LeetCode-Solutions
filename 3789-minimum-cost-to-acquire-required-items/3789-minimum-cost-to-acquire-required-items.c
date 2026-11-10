/*
Brute Force

long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    long long hi = need1 > need2 ? need1 : need2;
    long long best = (long long)need1 * cost1 + (long long)need2 * cost2;
    for (long long k = 1; k <= hi; k++) {
        long long cost = k * costBoth;
        if (need1 > k) cost += (need1 - k) * cost1;
        if (need2 > k) cost += (need2 - k) * cost2;
        if (cost < best) best = cost;
    }
    return best;
}
*/

/*
Better Approach

long long total(long long k, int cost1, int cost2, int costBoth, int need1, int need2) {
    long long cost = k * costBoth;
    if (need1 > k) cost += (need1 - k) * cost1;
    if (need2 > k) cost += (need2 - k) * cost2;
    return cost;
}

long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    long long lo = 0, hi = need1 > need2 ? need1 : need2;
    while (lo < hi) {
        long long mid = (lo + hi) / 2;
        if (total(mid, cost1, cost2, costBoth, need1, need2) <= total(mid + 1, cost1, cost2, costBoth, need1, need2)) hi = mid;
        else lo = mid + 1;
    }
    return total(lo, cost1, cost2, costBoth, need1, need2);
}
*/

long long minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    long long both = need1 < need2 ? need1 : need2;
    long long pair = costBoth < cost1 + cost2 ? costBoth : cost1 + cost2;
    long long one = cost1 < costBoth ? cost1 : costBoth;
    long long two = cost2 < costBoth ? cost2 : costBoth;
    return both * pair + (need1 - both) * one + (need2 - both) * two;
}