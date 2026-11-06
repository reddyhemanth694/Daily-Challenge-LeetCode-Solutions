/*
Brute Force

func countServers(n int, logs [][]int, x int, queries []int) []int {
	ans := make([]int, len(queries))
	for i, q := range queries {
		seen := make([]bool, n+1)
		cnt := 0
		for _, lg := range logs {
			if lg[1] >= q-x && lg[1] <= q && !seen[lg[0]] {
				seen[lg[0]] = true
				cnt++
			}
		}
		ans[i] = n - cnt
	}
	return ans
}
*/

/*
Better Approach

func countServers(n int, logs [][]int, x int, queries []int) []int {
	sort.Slice(logs, func(a, b int) bool { return logs[a][1] < logs[b][1] })
	m := len(logs)
	stamp := make([]int, n+1)
	for i := range stamp {
		stamp[i] = -1
	}
	ans := make([]int, len(queries))
	for i, q := range queries {
		j := sort.Search(m, func(k int) bool { return logs[k][1] >= q-x })
		cnt := 0
		for ; j < m && logs[j][1] <= q; j++ {
			if stamp[logs[j][0]] != i {
				stamp[logs[j][0]] = i
				cnt++
			}
		}
		ans[i] = n - cnt
	}
	return ans
}
*/

func countServers(n int, logs [][]int, x int, queries []int) []int {
	sort.Slice(logs, func(a, b int) bool { return logs[a][1] < logs[b][1] })
	k := len(queries)
	idx := make([]int, k)
	for i := range idx {
		idx[i] = i
	}
	sort.Slice(idx, func(a, b int) bool { return queries[idx[a]] < queries[idx[b]] })
	cnt := make([]int, n+1)
	ans := make([]int, k)
	l, r, distinct := 0, 0, 0
	for _, i := range idx {
		q := queries[i]
		for r < len(logs) && logs[r][1] <= q {
			if cnt[logs[r][0]] == 0 {
				distinct++
			}
			cnt[logs[r][0]]++
			r++
		}
		for l < r && logs[l][1] < q-x {
			cnt[logs[l][0]]--
			if cnt[logs[l][0]] == 0 {
				distinct--
			}
			l++
		}
		ans[i] = n - distinct
	}
	return ans
}