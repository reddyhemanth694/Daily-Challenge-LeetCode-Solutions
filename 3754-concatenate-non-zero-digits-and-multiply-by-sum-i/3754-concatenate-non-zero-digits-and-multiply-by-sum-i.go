/*
Brute Force

func sumAndMultiply(n int) int64 {
	t := strings.ReplaceAll(strconv.Itoa(n), "0", "")
	if t == "" {
		return 0
	}
	x, _ := strconv.ParseInt(t, 10, 64)
	var sum int64
	for _, c := range t {
		sum += int64(c - '0')
	}
	return x * sum
}
*/

/*
Better Approach

func sumAndMultiply(n int) int64 {
	digits := []int{}
	for ; n > 0; n /= 10 {
		digits = append(digits, n%10)
	}
	var x, sum int64
	for i := len(digits) - 1; i >= 0; i-- {
		if digits[i] != 0 {
			x = x*10 + int64(digits[i])
			sum += int64(digits[i])
		}
	}
	return x * sum
}
*/

func sumAndMultiply(n int) int64 {
	var x, sum, p int64 = 0, 0, 1
	for ; n > 0; n /= 10 {
		d := int64(n % 10)
		if d != 0 {
			x += d * p
			sum += d
			p *= 10
		}
	}
	return x * sum
}