/*
Brute Force

func minMoves(nums []int) int {
	moves := 0
	for {
		mn, mx := 0, 0
		for i := 1; i < len(nums); i++ {
			if nums[i] < nums[mn] {
				mn = i
			}
			if nums[i] > nums[mx] {
				mx = i
			}
		}
		if nums[mn] == nums[mx] {
			return moves
		}
		nums[mn]++
		moves++
	}
}
*/

/*
Better Approach

func minMoves(nums []int) int {
	sort.Ints(nums)
	moves := 0
	for _, x := range nums {
		moves += nums[len(nums)-1] - x
	}
	return moves
}
*/

func minMoves(nums []int) int {
	mx, sum := 0, 0
	for _, x := range nums {
		if x > mx {
			mx = x
		}
		sum += x
	}
	return mx*len(nums) - sum
}