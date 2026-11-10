/*
Brute Force

class Solution {
  int minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    int hi = need1 > need2 ? need1 : need2;
    int best = need1 * cost1 + need2 * cost2;
    for (int k = 1; k <= hi; k++) {
      int cost = k * costBoth;
      if (need1 > k) cost += (need1 - k) * cost1;
      if (need2 > k) cost += (need2 - k) * cost2;
      if (cost < best) best = cost;
    }
    return best;
  }
}
*/

/*
Better Approach

class Solution {
  int total(int k, int cost1, int cost2, int costBoth, int need1, int need2) {
    int cost = k * costBoth;
    if (need1 > k) cost += (need1 - k) * cost1;
    if (need2 > k) cost += (need2 - k) * cost2;
    return cost;
  }

  int minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    int lo = 0, hi = need1 > need2 ? need1 : need2;
    while (lo < hi) {
      int mid = (lo + hi) ~/ 2;
      if (total(mid, cost1, cost2, costBoth, need1, need2) <= total(mid + 1, cost1, cost2, costBoth, need1, need2)) {
        hi = mid;
      } else {
        lo = mid + 1;
      }
    }
    return total(lo, cost1, cost2, costBoth, need1, need2);
  }
}
*/

class Solution {
  int minimumCost(int cost1, int cost2, int costBoth, int need1, int need2) {
    int both = need1 < need2 ? need1 : need2;
    int pair = costBoth < cost1 + cost2 ? costBoth : cost1 + cost2;
    int one = cost1 < costBoth ? cost1 : costBoth;
    int two = cost2 < costBoth ? cost2 : costBoth;
    return both * pair + (need1 - both) * one + (need2 - both) * two;
  }
}