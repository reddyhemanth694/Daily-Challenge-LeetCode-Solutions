/*
Brute Force

func minMoves(nums []int) int {
	moves := 0
	for {
		mx, same := 0, true
		for i := 1; i < len(nums); i++ {
			if nums[i] != nums[0] {
				same = false
			}
			if nums[i] > nums[mx] {
				mx = i
			}
		}
		if same {
			return moves
		}
		for i := range nums {
			if i != mx {
				nums[i]++
			}
		}
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
		moves += x - nums[0]
	}
	return moves
}
*/

func minMoves(nums []int) int {
	mn := nums[0]
	for _, x := range nums {
		if x < mn {
			mn = x
		}
	}
	moves := 0
	for _, x := range nums {
		moves += x - mn
	}
	return moves
}