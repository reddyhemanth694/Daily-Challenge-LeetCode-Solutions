/*
Brute Force

func sumAndMultiply(s string, queries [][]int) []int {
	const mod = 1_000_000_007
	ans := make([]int, len(queries))
	for k, q := range queries {
		x, sum := 0, 0
		for i := q[0]; i <= q[1]; i++ {
			d := int(s[i] - '0')
			if d != 0 {
				x = (x*10 + d) % mod
				sum += d
			}
		}
		ans[k] = x * sum % mod
	}
	return ans
}
*/

/*
Better Approach

func power(b, e int) int {
	const mod = 1_000_000_007
	r := 1
	for e > 0 {
		if e&1 == 1 {
			r = r * b % mod
		}
		b = b * b % mod
		e >>= 1
	}
	return r
}

func sumAndMultiply(s string, queries [][]int) []int {
	const mod = 1_000_000_007
	m := len(s)
	pre, cnt, sum := make([]int, m+1), make([]int, m+1), make([]int, m+1)
	for i := 0; i < m; i++ {
		d := int(s[i] - '0')
		pre[i+1], cnt[i+1] = pre[i], cnt[i]
		if d != 0 {
			pre[i+1] = (pre[i]*10 + d) % mod
			cnt[i+1]++
		}
		sum[i+1] = sum[i] + d
	}
	ans := make([]int, len(queries))
	for k, q := range queries {
		l, r := q[0], q[1]+1
		x := ((pre[r]-pre[l]*power(10, cnt[r]-cnt[l]))%mod + mod) % mod
		ans[k] = x * (sum[r] - sum[l]) % mod
	}
	return ans
}
*/

func sumAndMultiply(s string, queries [][]int) []int {
	const mod = 1_000_000_007
	m := len(s)
	pre, pw := make([]int, m+1), make([]int, m+1)
	cnt, sum := make([]int, m+1), make([]int, m+1)
	pw[0] = 1
	for i := 0; i < m; i++ {
		d := int(s[i] - '0')
		pw[i+1] = pw[i] * 10 % mod
		pre[i+1], cnt[i+1] = pre[i], cnt[i]
		if d != 0 {
			pre[i+1] = (pre[i]*10 + d) % mod
			cnt[i+1]++
		}
		sum[i+1] = sum[i] + d
	}
	ans := make([]int, len(queries))
	for k, q := range queries {
		l, r := q[0], q[1]+1
		x := ((pre[r]-pre[l]*pw[cnt[r]-cnt[l]])%mod + mod) % mod
		ans[k] = x * (sum[r] - sum[l]) % mod
	}
	return ans
}