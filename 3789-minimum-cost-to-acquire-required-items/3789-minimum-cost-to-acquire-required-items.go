/*
Brute Force

func minimumCost(cost1 int, cost2 int, costBoth int, need1 int, need2 int) int64 {
	best := need1*cost1 + need2*cost2
	for k := 1; k <= max(need1, need2); k++ {
		best = min(best, k*costBoth+max(0, need1-k)*cost1+max(0, need2-k)*cost2)
	}
	return int64(best)
}
*/

/*
Better Approach

func minimumCost(cost1 int, cost2 int, costBoth int, need1 int, need2 int) int64 {
	total := func(k int) int {
		return k*costBoth + max(0, need1-k)*cost1 + max(0, need2-k)*cost2
	}
	lo, hi := 0, max(need1, need2)
	for lo < hi {
		mid := (lo + hi) / 2
		if total(mid) <= total(mid+1) {
			hi = mid
		} else {
			lo = mid + 1
		}
	}
	return int64(total(lo))
}
*/

func minimumCost(cost1 int, cost2 int, costBoth int, need1 int, need2 int) int64 {
	both := min(need1, need2)
	return int64(both*min(costBoth, cost1+cost2) + (need1-both)*min(cost1, costBoth) + (need2-both)*min(cost2, costBoth))
}