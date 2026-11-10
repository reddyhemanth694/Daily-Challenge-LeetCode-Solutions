/*
Brute Force

class Solution {
    func minimumCost(_ cost1: Int, _ cost2: Int, _ costBoth: Int, _ need1: Int, _ need2: Int) -> Int {
        var best = Int.max
        for k in 0...max(need1, need2) {
            best = min(best, k * costBoth + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2)
        }
        return best
    }
}
*/

/*
Better Approach

class Solution {
    func minimumCost(_ cost1: Int, _ cost2: Int, _ costBoth: Int, _ need1: Int, _ need2: Int) -> Int {
        func total(_ k: Int) -> Int {
            return k * costBoth + max(0, need1 - k) * cost1 + max(0, need2 - k) * cost2
        }
        var lo = 0, hi = max(need1, need2)
        while lo < hi {
            let mid = (lo + hi) / 2
            if total(mid) <= total(mid + 1) { hi = mid } else { lo = mid + 1 }
        }
        return total(lo)
    }
}
*/

class Solution {
    func minimumCost(_ cost1: Int, _ cost2: Int, _ costBoth: Int, _ need1: Int, _ need2: Int) -> Int {
        let both = min(need1, need2)
        return both * min(costBoth, cost1 + cost2) + (need1 - both) * min(cost1, costBoth) + (need2 - both) * min(cost2, costBoth)
    }
}