/*
Brute Force

func numOfSubarrays(arr []int) int {
	const mod = 1_000_000_007
	n, ans := len(arr), 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sum := 0
			for k := i; k <= j; k++ {
				sum += arr[k]
			}
			if sum%2 == 1 {
				ans = (ans + 1) % mod
			}
		}
	}
	return ans
}
*/

/*
Better Approach

func numOfSubarrays(arr []int) int {
	const mod = 1_000_000_007
	n, ans := len(arr), 0
	for i := 0; i < n; i++ {
		sum := 0
		for j := i; j < n; j++ {
			sum += arr[j]
			if sum%2 == 1 {
				ans = (ans + 1) % mod
			}
		}
	}
	return ans
}
*/

func numOfSubarrays(arr []int) int {
	const mod = 1_000_000_007
	odd, even, sum, ans := 0, 1, 0, 0
	for _, x := range arr {
		sum += x
		if sum%2 == 1 {
			ans = (ans + even) % mod
			odd++
		} else {
			ans = (ans + odd) % mod
			even++
		}
	}
	return ans
}