/*
Brute Force

func minimumSumSubarray(nums []int, l int, r int) int {
	n, ans := len(nums), -1
	for i := 0; i < n; i++ {
		for length := l; length <= r && i+length <= n; length++ {
			sum := 0
			for j := i; j < i+length; j++ {
				sum += nums[j]
			}
			if sum > 0 && (ans == -1 || sum < ans) {
				ans = sum
			}
		}
	}
	return ans
}
*/

/*
Better Approach

func minimumSumSubarray(nums []int, l int, r int) int {
	n, ans := len(nums), -1
	for i := 0; i < n; i++ {
		sum := 0
		for j := i; j < n && j-i+1 <= r; j++ {
			sum += nums[j]
			if j-i+1 >= l && sum > 0 && (ans == -1 || sum < ans) {
				ans = sum
			}
		}
	}
	return ans
}
*/

func minimumSumSubarray(nums []int, l int, r int) int {
	n, ans := len(nums), -1
	pre := make([]int, n+1)
	for i, v := range nums {
		pre[i+1] = pre[i] + v
	}
	win := []int{}
	for j := l; j <= n; j++ {
		pos := sort.SearchInts(win, pre[j-l])
		win = append(win, 0)
		copy(win[pos+1:], win[pos:])
		win[pos] = pre[j-l]
		if j-r-1 >= 0 {
			pos = sort.SearchInts(win, pre[j-r-1])
			win = append(win[:pos], win[pos+1:]...)
		}
		if idx := sort.SearchInts(win, pre[j]); idx > 0 {
			if cand := pre[j] - win[idx-1]; ans == -1 || cand < ans {
				ans = cand
			}
		}
	}
	return ans
}