/*
Brute Force

func longestMonotonicSubarray(nums []int) int {
	n, res := len(nums), 1
	for i := 0; i < n; i++ {
		inc, dec := 1, 1
		for i+inc < n && nums[i+inc] > nums[i+inc-1] {
			inc++
		}
		for i+dec < n && nums[i+dec] < nums[i+dec-1] {
			dec++
		}
		res = max(res, inc, dec)
	}
	return res
}
*/

/*
Better Approach

func longestMonotonicSubarray(nums []int) int {
	res, length := 1, 1
	for i := 1; i < len(nums); i++ {
		if nums[i] > nums[i-1] {
			length++
		} else {
			length = 1
		}
		res = max(res, length)
	}
	length = 1
	for i := 1; i < len(nums); i++ {
		if nums[i] < nums[i-1] {
			length++
		} else {
			length = 1
		}
		res = max(res, length)
	}
	return res
}
*/

func longestMonotonicSubarray(nums []int) int {
	res, inc, dec := 1, 1, 1
	for i := 1; i < len(nums); i++ {
		if nums[i] > nums[i-1] {
			inc++
		} else {
			inc = 1
		}
		if nums[i] < nums[i-1] {
			dec++
		} else {
			dec = 1
		}
		res = max(res, inc, dec)
	}
	return res
}