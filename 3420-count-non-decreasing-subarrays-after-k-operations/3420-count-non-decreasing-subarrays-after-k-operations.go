/*
Brute Force

func countNonDecreasingSubarrays(nums []int, k int) int64 {
	n, ans := len(nums), 0
	for l := 0; l < n; l++ {
		mx, cost := 0, 0
		for r := l; r < n; r++ {
			mx = max(mx, nums[r])
			cost += mx - nums[r]
			if cost > k {
				break
			}
			ans++
		}
	}
	return int64(ans)
}
*/

/*
Better Approach

func countNonDecreasingSubarrays(nums []int, k int) int64 {
	n, lg := len(nums), 1
	for 1<<lg <= n {
		lg++
	}
	pre := make([]int, n+1)
	for i, v := range nums {
		pre[i+1] = pre[i] + v
	}
	up, sum := make([][]int, lg), make([][]int, lg)
	for j := range up {
		up[j], sum[j] = make([]int, n+1), make([]int, n+1)
	}
	up[0][n] = n
	st := []int{}
	for i := n - 1; i >= 0; i-- {
		for len(st) > 0 && nums[st[len(st)-1]] <= nums[i] {
			st = st[:len(st)-1]
		}
		nx := n
		if len(st) > 0 {
			nx = st[len(st)-1]
		}
		st = append(st, i)
		up[0][i] = nx
		sum[0][i] = nums[i]*(nx-i) - (pre[nx] - pre[i])
	}
	for j := 1; j < lg; j++ {
		for i := 0; i <= n; i++ {
			up[j][i] = up[j-1][up[j-1][i]]
			sum[j][i] = sum[j-1][i] + sum[j-1][up[j-1][i]]
		}
	}
	ans := 0
	for l := 0; l < n; l++ {
		cur, acc := l, 0
		for j := lg - 1; j >= 0; j-- {
			if cur < n && acc+sum[j][cur] <= k {
				acc += sum[j][cur]
				cur = up[j][cur]
			}
		}
		if cur == n {
			ans += n - l
			continue
		}
		lo, hi := cur, up[0][cur]-1
		for lo < hi {
			mid := (lo + hi + 1) / 2
			if acc+nums[cur]*(mid-cur+1)-(pre[mid+1]-pre[cur]) <= k {
				lo = mid
			} else {
				hi = mid - 1
			}
		}
		ans += lo - l + 1
	}
	return int64(ans)
}
*/

func countNonDecreasingSubarrays(nums []int, k int) int64 {
	n := len(nums)
	dq := make([]int, n)
	head, tail, r, ans, cost := n, n, n-1, 0, 0
	for l := n - 1; l >= 0; l-- {
		for head < tail && nums[dq[head]] <= nums[l] {
			i := dq[head]
			head++
			end := r + 1
			if head < tail {
				end = dq[head]
			}
			cost += (nums[l] - nums[i]) * (end - i)
		}
		head--
		dq[head] = l
		for cost > k {
			cost -= nums[dq[tail-1]] - nums[r]
			if dq[tail-1] == r {
				tail--
			}
			r--
		}
		ans += r - l + 1
	}
	return int64(ans)
}