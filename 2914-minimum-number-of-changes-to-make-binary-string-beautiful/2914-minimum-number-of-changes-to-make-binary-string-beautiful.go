/*
Brute Force

func minChanges(s string) int {
	n := len(s)
	var solve func(i int) int
	solve = func(i int) int {
		if i == n {
			return 0
		}
		best, ones := n, 0
		for j := i; j < n; j++ {
			if s[j] == '1' {
				ones++
			}
			if length := j - i + 1; length%2 == 0 {
				best = min(best, min(ones, length-ones)+solve(j+1))
			}
		}
		return best
	}
	return solve(0)
}
*/

/*
Better Approach

func minChanges(s string) int {
	n := len(s)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = n
	}
	for i := 0; i < n; i += 2 {
		ones := 0
		for j := i; j < n; j++ {
			if s[j] == '1' {
				ones++
			}
			if length := j - i + 1; length%2 == 0 {
				dp[j+1] = min(dp[j+1], dp[i]+min(ones, length-ones))
			}
		}
	}
	return dp[n]
}
*/

func minChanges(s string) int {
	ans := 0
	for i := 0; i < len(s); i += 2 {
		if s[i] != s[i+1] {
			ans++
		}
	}
	return ans
}