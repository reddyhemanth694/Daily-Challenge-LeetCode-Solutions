/*
Brute Force

func findTheDistanceValue(arr1 []int, arr2 []int, d int) int {
	ans := 0
	for _, a := range arr1 {
		ok := true
		for _, b := range arr2 {
			if a-b <= d && b-a <= d {
				ok = false
				break
			}
		}
		if ok {
			ans++
		}
	}
	return ans
}
*/

/*
Better Approach

func findTheDistanceValue(arr1 []int, arr2 []int, d int) int {
	sort.Ints(arr2)
	ans := 0
	for _, a := range arr1 {
		i := sort.SearchInts(arr2, a-d)
		if i == len(arr2) || arr2[i] > a+d {
			ans++
		}
	}
	return ans
}
*/

func findTheDistanceValue(arr1 []int, arr2 []int, d int) int {
	pre := make([]int, 2202)
	for _, v := range arr2 {
		pre[v+1101]++
	}
	for i := 1; i < 2202; i++ {
		pre[i] += pre[i-1]
	}
	ans := 0
	for _, a := range arr1 {
		if pre[a+d+1101] == pre[a-d+1100] {
			ans++
		}
	}
	return ans
}