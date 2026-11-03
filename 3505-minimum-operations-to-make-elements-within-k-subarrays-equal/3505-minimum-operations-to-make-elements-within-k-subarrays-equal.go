/*
Brute Force

func minOperations(nums []int, x int, k int) int64 {
	n := len(nums)
	windowCost := func(i int) int64 {
		w := append([]int(nil), nums[i:i+x]...)
		sort.Ints(w)
		med, cost := w[x/2], int64(0)
		for _, v := range w {
			if v > med {
				cost += int64(v - med)
			} else {
				cost += int64(med - v)
			}
		}
		return cost
	}
	var dfs func(i, j int) int64
	dfs = func(i, j int) int64 {
		if j == 0 {
			return 0
		}
		if n-i < j*x {
			return -1
		}
		skip := dfs(i+1, j)
		take := windowCost(i) + dfs(i+x, j-1)
		if skip == -1 || take < skip {
			return take
		}
		return skip
	}
	return dfs(0, k)
}
*/

/*
Better Approach

func minOperations(nums []int, x int, k int) int64 {
	n := len(nums)
	cost := make([]int64, n-x+1)
	for i := 0; i+x <= n; i++ {
		w := append([]int(nil), nums[i:i+x]...)
		sort.Ints(w)
		med := w[x/2]
		for _, v := range w {
			if v > med {
				cost[i] += int64(v - med)
			} else {
				cost[i] += int64(med - v)
			}
		}
	}
	const inf = int64(1) << 60
	prev, cur := make([]int64, n+1), make([]int64, n+1)
	for j := 1; j <= k; j++ {
		for i := range cur {
			cur[i] = inf
		}
		for i := x; i <= n; i++ {
			cur[i] = cur[i-1]
			if take := prev[i-x] + cost[i-x]; take < cur[i] {
				cur[i] = take
			}
		}
		prev, cur = cur, prev
	}
	return prev[n]
}
*/

func minOperations(nums []int, x int, k int) int64 {
	n := len(nums)
	vals := append([]int(nil), nums...)
	sort.Ints(vals)
	m := 0
	for i, v := range vals {
		if i == 0 || v != vals[i-1] {
			vals[m] = v
			m++
		}
	}
	vals = vals[:m]
	top := 1
	for top*2 <= m {
		top *= 2
	}
	idx := make([]int, n)
	for i, v := range nums {
		idx[i] = sort.SearchInts(vals, v) + 1
	}
	cnt, sum, cost := make([]int64, m+1), make([]int64, m+1), make([]int64, n-x+1)
	update := func(i int, d int64) {
		for p := idx[i]; p <= m; p += p & -p {
			cnt[p] += d
			sum[p] += d * int64(nums[i])
		}
	}
	total, half := int64(0), int64((x+1)/2)
	for i := 0; i < n; i++ {
		update(i, 1)
		total += int64(nums[i])
		if i >= x {
			update(i-x, -1)
			total -= int64(nums[i-x])
		}
		if i >= x-1 {
			pos, need, lowCnt, lowSum := 0, half, int64(0), int64(0)
			for step := top; step > 0; step >>= 1 {
				if pos+step <= m && cnt[pos+step] < need {
					pos += step
					need -= cnt[pos]
					lowCnt += cnt[pos]
					lowSum += sum[pos]
				}
			}
			med := int64(vals[pos])
			cost[i-x+1] = med*lowCnt - lowSum + (total - lowSum) - med*(int64(x)-lowCnt)
		}
	}
	const inf = int64(1) << 60
	prev, cur := make([]int64, n+1), make([]int64, n+1)
	for j := 1; j <= k; j++ {
		for i := range cur {
			cur[i] = inf
		}
		for i := x; i <= n; i++ {
			cur[i] = cur[i-1]
			if take := prev[i-x] + cost[i-x]; take < cur[i] {
				cur[i] = take
			}
		}
		prev, cur = cur, prev
	}
	return prev[n]
}