/*
Brute Force

func minMoves2(nums []int) int {
	best := -1
	for _, x := range nums {
		cost := 0
		for _, a := range nums {
			if a > x {
				cost += a - x
			} else {
				cost += x - a
			}
		}
		if best == -1 || cost < best {
			best = cost
		}
	}
	return best
}
*/

/*
Better Approach

func minMoves2(nums []int) int {
	sort.Ints(nums)
	median, moves := nums[len(nums)/2], 0
	for _, a := range nums {
		if a > median {
			moves += a - median
		} else {
			moves += median - a
		}
	}
	return moves
}
*/

func minMoves2(nums []int) int {
	k, lo, hi, median := len(nums)/2, 0, len(nums)-1, 0
	for {
		pivot := nums[(lo+hi)/2]
		lt, i, gt := lo, lo, hi
		for i <= gt {
			if nums[i] < pivot {
				nums[lt], nums[i] = nums[i], nums[lt]
				lt++
				i++
			} else if nums[i] > pivot {
				nums[i], nums[gt] = nums[gt], nums[i]
				gt--
			} else {
				i++
			}
		}
		if k < lt {
			hi = lt - 1
		} else if k > gt {
			lo = gt + 1
		} else {
			median = pivot
			break
		}
	}
	moves := 0
	for _, a := range nums {
		if a > median {
			moves += a - median
		} else {
			moves += median - a
		}
	}
	return moves
}