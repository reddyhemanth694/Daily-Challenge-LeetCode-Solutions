/*
Brute Force

impl Solution {
    pub fn minimum_cost(cost1: i32, cost2: i32, cost_both: i32, need1: i32, need2: i32) -> i64 {
        let (c1, c2, cb, n1, n2) = (cost1 as i64, cost2 as i64, cost_both as i64, need1 as i64, need2 as i64);
        (0..=n1.max(n2))
            .map(|k| k * cb + (n1 - k).max(0) * c1 + (n2 - k).max(0) * c2)
            .min()
            .unwrap()
    }
}
*/

/*
Better Approach

impl Solution {
    pub fn minimum_cost(cost1: i32, cost2: i32, cost_both: i32, need1: i32, need2: i32) -> i64 {
        let (c1, c2, cb, n1, n2) = (cost1 as i64, cost2 as i64, cost_both as i64, need1 as i64, need2 as i64);
        let total = |k: i64| k * cb + (n1 - k).max(0) * c1 + (n2 - k).max(0) * c2;
        let (mut lo, mut hi) = (0, n1.max(n2));
        while lo < hi {
            let mid = (lo + hi) / 2;
            if total(mid) <= total(mid + 1) {
                hi = mid;
            } else {
                lo = mid + 1;
            }
        }
        total(lo)
    }
}
*/

impl Solution {
    pub fn minimum_cost(cost1: i32, cost2: i32, cost_both: i32, need1: i32, need2: i32) -> i64 {
        let (c1, c2, cb, n1, n2) = (cost1 as i64, cost2 as i64, cost_both as i64, need1 as i64, need2 as i64);
        let both = n1.min(n2);
        both * cb.min(c1 + c2) + (n1 - both) * c1.min(cb) + (n2 - both) * c2.min(cb)
    }
}